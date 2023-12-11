class GroupsController < ApplicationController
  before_action :set_group, only: %i[show]

  # GET /groups or /groups.json
  def index
    @groups = Group.includes([:user]).where(user: current_user)
    @total_amounts = calculate_total_amounts(@groups)
  end

  # GET /groups/1 or /groups/1.json
  def show
    @group = Group.find(params[:id])
    @deal = Deal.new(group: @group)
    @total_amount = @group.deals.sum(:amount)
  end

  # GET /groups/new
  def new
    @group = current_user.groups.build
  end

  # POST /groups or /groups.json
  def create
    @group = current_user.groups.build(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to '/groups', notice: 'Category was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name, :icon, :created_at)
  end

  def calculate_total_amounts(groups)
    total_amounts = {}
    groups.each do |group|
      total_amounts[group.id] = group.deals.sum(:amount)
    end
    total_amounts
  end
end
