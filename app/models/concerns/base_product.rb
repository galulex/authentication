module BaseProduct

  def self.included(base)
    base.mount_uploader :software, SoftwareUploader
    base.mount_uploader :icon, LogoUploader
    base.mount_uploader :image, ImageUploader
    base.mount_uploader :banner, BannerUploader

    base.has_many :images, as: :imageable, class_name: 'ProductImage', dependent: :delete_all
    base.has_many :videos, as: :videoable, class_name: 'ProductVideo', dependent: :delete_all
    base.has_many :resources, as: :resourceable, class_name: 'ProductResource', dependent: :delete_all
    base.has_many :pricings, as: :pricingable, class_name: 'ProductPricing', dependent: :delete_all
    base.has_many :product_categories, as: :categorizable, dependent: :delete_all
    base.has_many :categories, through: :product_categories

    base.attr_accessible :platform, :description, :features, :name, :summary, :support, :featured, :category_ids,
                  :version, :icon, :software, :image, :banner, :single_pricing, :pricing_type, :pricings_attributes,
                  :phone_form_factor, :tablet_form_factor, :images_attributes, :videos_attributes, :resources_attributes
    base.accepts_nested_attributes_for :videos, :resources, :pricings, :images, allow_destroy: true, reject_if: :all_blank

    base.validates :platform, :name, :version, :software, :description, :icon, :features, :summary, :support, presence: true
    base.validates :tablet_form_factor, :phone_form_factor, presence: true, if: lambda { |p| !p.phone_form_factor? && !p.tablet_form_factor? }

    base.state_machine :status, initial: 'draft' do
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
end
