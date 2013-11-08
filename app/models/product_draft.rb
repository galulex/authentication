class ProductDraft < ActiveRecord::Base

  belongs_to :product

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

  def approve!
    publish
    product.update_attributes(attributes)
    destroy
  end

  # searchable do
  # text :name, :description
  # end

end
