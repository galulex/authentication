class Company < ActiveRecord::Base

  has_many :users

  attr_accessible :name, :logo, :synopsis, :description

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

  end

  def company_id
    id
  end

  def before_instantiate_draft
    self.status = 'draft'
    p self.inspect
  end

  def status
    return draft.status if draft
    super
  end

  def pending?
    draft.pending? if draft
  end

end
