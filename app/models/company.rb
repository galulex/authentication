class Company < ActiveRecord::Base

  has_many :users

  attr_accessible :name, :logo, :synopsis, :description

  validates :name, presence: true, uniqueness: true

  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_draft do
    has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }

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
