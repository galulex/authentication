class Product < ActiveRecord::Base
  include HasDraft
  mount_uploader :icon, LogoUploader
  mount_uploader :image, ImageUploader
  mount_uploader :banner, BannerUploader

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :reviews, class_name: 'ProductReview'
  has_many :ratings, class_name: 'ProductRating'
  belongs_to :company

  attr_accessible :description, :features, :name, :summary, :support, :version, :icon
  validates :description, :features, :name, :summary, presence: true

  has_draft do
    mount_uploader :icon, LogoUploader
    mount_uploader :image, ImageUploader
    mount_uploader :banner, BannerUploader

    def user_rating(user)
      product.user_rating(user)
    end

    def company
      product.company
    end

    def reviews
      product.reviews
    end

    def ratings
      product.ratings
    end

    def to_param
      product.slug
    end

    validates :description, :features, :name, :summary, presence: true

    state_machine :status, initial: 'draft' do
      event :submit do
        transition to: 'pending', from: %w(draft declined retracted unpublished)
      end

      event :publish do
        transition to: 'published', from: %w(draft declined pending)
      end

      event :decline do
        transition to: 'declined', from: 'pending'
      end

      event :retract do
        transition to: 'retracted', from: 'published'
      end

      event :unpublish do
        transition to: 'unpublished', from: 'published'
      end
    end

  end

  state_machine :status, initial: 'draft' do
    event :submit do
      transition to: 'pending', from: %w(draft declined retracted unpublished)
    end

    event :publish do
      transition to: 'published', from: %w(draft declined pending)
    end

    event :decline do
      transition to: 'declined', from: 'pending'
    end

    event :retract do
      transition to: 'retracted', from: 'published'
    end

    event :unpublish do
      transition to: 'unpublished', from: 'published'
    end
  end

  def before_instantiate_draft
    self.status = 'draft'
  end

  def rate_it!(user, score)
    r = ratings.find_or_initialize_by_user_id(user.id)
    r.update_attributes(score: score)
    reload
  end

  def user_rating(user)
    rate = ratings.find_by_user_id(user.id)
    return rate.score if rate
    0
  end

  def user_review_id(user)
    review = reviews.find_by_user_id(user.id)
    review.id if review
  end

  searchable do
    text :name, :description
  end


end
