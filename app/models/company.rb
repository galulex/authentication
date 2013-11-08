class Company < ActiveRecord::Base

  mount_uploader :logo, LogoUploader

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :users
  has_many :products
  has_one :draft, class_name: CompanyDraft

  attr_accessible :name, :logo, :synopsis, :description, :street1, :street2,
                  :city, :country, :state, :postal_code, :phone, :website

  validates :name, :logo, :synopsis, :description, :street1, :city, :website,
            :country, :state, presence: true, on: :update
  validates :name, uniqueness: true

  scope :starts_with, ->(char) { where('name LIKE ?', "#{char}%") if char }

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

end
