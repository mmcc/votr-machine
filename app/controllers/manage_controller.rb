class ManageController < ApplicationController
  before_filter :authenticate_user!

  # GET /manage
  def index
    @rounds = current_user.rounds
  end

  def create
  end

  def edit
  end

  # GET /manage/:id
  def show
    @round = current_user.rounds.find(params[:id])
    @items = @round.items.order('votes DESC')
  end

  def new
  end

  def destroy
  end
end
