class Company < ActiveRecord::Base

  has_many :users
  has_many :products

  attr_accessible :name, :logo, :synopsis, :description, :street1, :street2, :city, :country, :state, :postal_code, :phone, :website

  validates :name, presence: true, uniqueness: true

  has_attached_file :logo, :styles => { one: '55x55', two: '78x78', three: '114x114', four: '144x144', original: '190x90' }

  has_draft do

    validates :name, :synopsis, :description, :street1, :city, :website, :country, :state, presence: true, on: :update
    validates_attachment :logo, attachment_presence: true, content_type: { content_type: /^image\/(png|gif|jpeg)/ }, on: :update

    has_attached_file :logo, :styles => { one: '55x55', two: '78x78', three: '114x114', four: '144x144', original: '190x90' }

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
