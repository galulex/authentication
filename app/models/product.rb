class Product < ActiveRecord::Base
  include BaseProduct
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :reviews, class_name: ProductReview, dependent: :delete_all
  has_many :ratings, class_name: ProductRating, dependent: :delete_all
  has_one  :draft,   class_name: ProductDraft, dependent: :destroy
  belongs_to :company

  scope :search, ->(q) { where(['name LIKE ?', "%#{q}%"]) }
  scope :sorted, -> { includes(:draft).order('product_drafts.status DESC, products.name ASC') }

  def rate_it!(user, score)
    r = ratings.find_or_initialize_by(user_id: user.id)
    r.update_attributes(score: score)
    reload
  end

  def user_rating(user)
    @rate ||= ratings.find_by_user_id(user.id)
    return @rate.score if @rate
    0
  end

  def user_review_id(user)
    review = reviews.find_by_user_id(user.id)
    review.id if review
  end

  def product_id
    id
  end

  def approve!
    publish! unless published?
  end

  def product_status
    return draft.status if draft
    status
  end

  def draft_or_build
    draft || build_draft(attributes)
    draft.icon = icon unless draft.icon?
    draft.image = image unless draft.image?
    draft.banner = banner unless draft.banner?
    draft
  end

  private

  def delete_associations
    images.delete_all
    videos.delete_all
    resources.delete_all
    pricings.delete_all
  end

end
