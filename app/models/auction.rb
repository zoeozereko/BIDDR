class Auction < ActiveRecord::Base
  include AASM

  belongs_to :user

  has_many :bids, dependent: :destroy

  validates :title, presence: true
  validates :details, presence: true
  validates :ends_on, presence: true
  validates :reserve_price, numericality: {greater_than_or_equal_to: 10}

  aasm whiny_transitions: false do
    state :published, initial: true
    state :reserve_met
    state :won
    state :cancelled
    state :reserve_not_met

    event :met do
      transitions from: :published, to: :reserve_met
    end
  end

end
