class BidsController < ApplicationController

  def create
    @auction = Auction.find(params[:auction_id])
    @bid = current_user.bids.new(bid_params)
    @bid.auction = @auction
    if @auction.bids.count == 0 || @bid.amount > @auction.bids.maximum(:amount)
      if @bid.save
        redirect_to @auction, notice: "Bid has been created"
      else
        flash[:alert] = "Bid has not been created"
        render "auctions/show"
      end
    else
      flash[:alert] = "Bid must be higher then the maximum bid"
      redirect_to @auction
    end
  end

  def destroy
    @auction = Auction.find(params[:auction_id])
    @bid = Bid.find(params[:id])
    @bid.destroy
    redirect_to @auction, notice: "Bid has been destroyed"
  end

  private
  def bid_params
    params.require(:bid).permit(:amount)
  end

end
