require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
  let(:auction)   { create(:auction) }
  let(:auction_1) { create(:auction) }

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns an instance variable for all the auctions" do
      auction
      auction_1
      get :index
      expect(assigns(:auctions)).to eq [auction, auction_1]
    end
  end

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "set a instance variable to a new auction" do
      get :new
      expect(assigns(:auction)).to be_a_new Auction
    end
  end

  describe "#create" do
    context "with valid parameters" do
      def valid_request
        post :create, auction: attributes_for(:auction)
      end

      it "creates a new campaign in the database" do
        expect { valid_request }.to change { Auction.count }.by(1)
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end

      it "redirect to auction show page" do
        valid_request
        expect(response).to redirect_to(auction_path(Auction.last))
      end
    end

    context "with invalid parameters" do
      def invalid_request
        post :create, auction: {reserve_price: "hi"}
      end

      it "doesn't create a record in the database" do
        expect{ invalid_request }.to change { Auction.count }.by(0)
      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end

      it "sets a flash message" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#show" do
    before { get :show, id: auction.id }

    it "renders the show template" do
      expect(response).to render_template(:show)
    end

    it "sets an instance variable with the auction whose id is passed" do
      expect(assigns(:auction)).to eq(auction)
    end
  end

  describe "#edit" do
    before { get :edit, id: auction_1.id }

    it "renders the edit template" do
      expect(response).to render_template(:edit)
    end

    it "sets a auction instance variable with the id passed" do
      expect(assigns(:auction)).to eq(auction_1)
    end
  end

  describe "#update" do
    def valid_attributes(new_attributes = {})
      attributes_for(:auction).merge(new_attributes)
    end

    context "with valid attributes" do
      before do
        patch :update, id: auction_1.id,
                       auction: valid_attributes(title: "New Auction")
      end

      it "updates the record in the database" do
        expect(auction_1.reload.title).to eq "New Auction"
      end

      it "redirects to the show page" do
        expect(response).to redirect_to(auction_path(auction_1))
      end

      it "sets a flash message" do
        expect(flash[:notice]).to be
      end
    end

    context "with invalid attributes" do
      before do
        patch :update, id: auction_1.id,
                       auction: valid_attributes(title: "")
      end

      it "doesn't update the record in the database" do
        expect(auction_1.reload.title).to_not eq("")
      end

      it "renders the edit template" do
        expect(response).to render_template(:edit)
      end

      it "sets a flash message" do
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#destroy" do
    it "reduces the number of auctions in the database by 1" do
      auction_1
      expect { delete :destroy, id: auction_1.id }.to change { Auction.count }.by(-1)
    end

    it "redirects to the auction's index page" do
      delete :destroy, id: auction_1.id
      expect(response).to redirect_to auctions_path
    end

    it "sets a flash message" do
      delete :destroy, id: auction_1.id
      expect(flash[:notice]).to be
    end
  end

end
