class AuctionsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :find_auction, only: [:show, :edit, :update, :destroy]

  def index
    @auctions = Auction.all
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new(auction_params)
    if @auction.save
      flash[:notice] = "Auction has been created"
      redirect_to auction_path(@auction)
    else
      flash[:alert] = "Auction has not been created"
      render :new
    end
  end

  def show
    @bid = Bid.new
  end

  def edit
  end

  def update
    if @auction.update(auction_params)
      redirect_to @auction, notice: "Auction has been updated"
    else
      flash[:alert] = "Auction has not been updated"
      render :edit
    end
  end

  def destroy
    @auction.destroy
    redirect_to auctions_path, notice: "Auction has been deleted"
  end

  private
  def find_auction
    @auction = Auction.find(params[:id])
  end

  def auction_params
    params.require(:auction).permit(:title, :details, :ends_on, :reserve_price)
  end

end
