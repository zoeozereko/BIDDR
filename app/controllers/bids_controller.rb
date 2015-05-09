class BidsController < ApplicationController

  def index
    @bids = current_user.bids.all
  end

  def create
    @auction = Auction.find(params[:auction_id])
    @bid = current_user.bids.new(bid_params)
    @bid.auction = @auction
    if @auction.bids.count == 0 || @bid.amount > @auction.bids.maximum(:amount)
    respond_to do |format|
      if @bid.save
        if @bid.amount >= @auction.reserve_price
          @auction.met
          @auction.save
        end
        format.html {redirect_to @auction, notice: "Bid has been created"}
        format.js {render :create_success}
      else
        format.html {render "auctions/show"}
        format.js {render :create_failure}
      end
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
