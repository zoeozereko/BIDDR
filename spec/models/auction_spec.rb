require 'rails_helper'

RSpec.describe Auction, type: :model do
  def valid_attributes(new_attributes)
    attributes = {title: "A new car!",
                  details: "I'm selling my fancy car to a lucky bidder.",
                  ends_on: (Time.now + 30.days),
                  reserve_price: 5000}
    attributes.merge(new_attributes)
  end

  describe "validations" do

    it "requires a title" do
      a = Auction.new(valid_attributes(title: nil))
      expect(a).to be_invalid
    end

    it "requires details" do
      a = Auction.new(valid_attributes(details: nil))
      expect(a).to be_invalid
    end

    it "requires an end date" do
      a = Auction.new(valid_attributes(ends_on: nil))
      expect(a).to be_invalid
    end

    it "requires a reserve price to be $10 or higher" do
      a = Auction.new(valid_attributes(reserve_price: 2))
      a.save
      expect(a.errors.messages).to have_key(:reserve_price)
    end

  end

end
