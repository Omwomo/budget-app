class DealsController < ApplicationController
  before_action :set_deal, only: %i[show edit destroy]

  # GET /deals or /deals.json
  def index
    @deals = Deal.all
  end

  # GET /deals/1 or /deals/1.json
  def show
  end

  # GET /deals/new
  def new
    @group = Group.find(params[:group_id])
    @deal = @group.deals.build(user_id: current_user.id)
  end

  # GET /deals/1/edit
  def edit
  end

  # POST /deals or /deals.json
  def create
    @deal = Deal.new(deal_params)
    @group = Group.find(params[:group_id])
    @deal.group = @group
    @deal.user = current_user # Assign the current user to the deal

    respond_to do |format|
      if @deal.save
        format.html { redirect_to group_path(@group), notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @deal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deals/1 or /deals/1.json
  def destroy
    @deal.destroy!

    respond_to do |format|
      format.html { redirect_to deals_url, notice: "Deal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_deal
    @deal = Deal.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def deal_params
    params.require(:deal).permit(:author_id, :name, :amount, :created_at, :user_id, :group_id)
  end
end
