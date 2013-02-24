class Company < ActiveRecord::Base
  include HasDraft
  mount_uploader :logo, LogoUploader

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :users
  has_many :products

  attr_accessible :name, :logo, :synopsis, :description, :street1, :street2, :city, :country, :state, :postal_code, :phone, :website

  validates :name, :logo, :synopsis, :description, :street1, :city, :website, :country, :state, presence: true, on: :update
  validates :name, uniqueness: true


  has_draft do

    mount_uploader :logo, LogoUploader

    validates :name, :logo, :synopsis, :description, :street1, :city, :website, :country, :state, presence: true, on: :update

    state_machine :status, :initial => 'draft' do
      event :submit do
        transition to: 'pending', from: %w(draft declined)
      end

      event :approve do
        transition to: 'approved', from: %w(draft declined pending)
      end

      event :decline do
        transition to: 'declined', from: 'pending'
      end
    end

    def to_param
      company_id
    end

  end

  def company_id
    id
  end

  def before_instantiate_draft
    self.status = 'draft'
  end

  def company_status
    return draft.status if draft
    status
  end

  def pending?
    draft.pending? if draft
  end

  def published?
    status != 'draft'
  end

  def published_at
    created_at if published?
  end

end
