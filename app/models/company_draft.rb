class CompanyDraft < ActiveRecord::Base

  mount_uploader :logo, LogoUploader

  attr_accessible :name, :logo, :synopsis, :description, :street1, :street2,
                  :city, :country, :state, :postal_code, :phone, :website
  validates       :name, :logo, :synopsis, :description, :street1, :city,
                  :website, :country, :state, presence: true

  belongs_to :company

  state_machine :status, initial: 'draft' do
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
    company.slug.to_s
  end

  def self.model_name
    Company.model_name
  end

  def publish!
    approve
    company.update_attributes(attributes)
    destroy
  end

end
