class Product < ActiveRecord::Base

  has_many :reviews, class_name: 'ProductReview'
  belongs_to :company

  attr_accessible :description, :features, :name, :summary, :support, :version, :icon
  validates :description, :features, :name, :summary, presence: true


  has_attached_file :icon
  has_attached_file :image
  has_attached_file :banner

  has_draft do

    validates :name, :description, presence: true
    has_attached_file :icon
    has_attached_file :image
    has_attached_file :banner

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
        transition to: 'retracted', from: 'pending published declined'
      end

      event :unpublish do
        transition to: 'unpublished', from: 'published'
      end
    end

end
