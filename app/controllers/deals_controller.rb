class DealsController < ApplicationController
  def index
    # Index action logic here
  end

  # GET /deals/new
  def new
    @group = Group.find(params[:group_id])
    @deal = @group.deals.build(user_id: current_user.id)
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
      else
        format.html { render :new, status: :unprocessable_entity }
      end
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
