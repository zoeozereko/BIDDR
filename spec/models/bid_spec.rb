require 'rails_helper'

RSpec.describe Bid, type: :model do
  # def valid_attributes(new_attributes)
  #   attributes = {amount: 50}
  #   attributes.merge(new_attributes)
  # end

  describe "validations" do
    # bid = Bid.new(amount: 10)
    # bid_2 = Bid.new(amount: 9)

    it "requires an amount of 1 or more" do
      b = Bid.new(amount:0)
      expect(b).to be_invalid
    end

    it "requires the amount to be a number" do
      b = Bid.new(amount: "asdasd")
      b.save
      expect(b.errors.messages).to have_key(:amount)
    end

  end

end
