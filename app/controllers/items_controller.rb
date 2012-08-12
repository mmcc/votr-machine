class ItemsController < ApplicationController
  before_filter :authenticate_user!

  # GET /manage
  def index
    @items
  end

  def create
  end

  def update
    @round = Round.find(params[:round_id])
    unless @round.end_time.past?
      @items = @round.items.order("title")
      @item = @items.find(params[:id])
      @item.votes = @item.votes + 1
      @round.total_votes = @round.total_votes + 1

      if @item.save and @round.save
        @items = Round.find(params[:round_id]).items
        puts "Total votes: #{@round.total_votes}"

        publish = PUBNUB.publish({
          'channel' => @round.channel,
          'message' => { 'total_votes' => @round.total_votes, 'items' => @items },
          'callback' => lambda do |message|
            puts message
          end
        })

        render :status => 200, :json => { 'round' => @round, 'songs' => @items }
      end
    end
  end

  def new
  end

  def destroy
    @round = Round.find(params[:round_id])
    @item = @round.items.find(params[:id])

    @round.total_votes = @round.total_votes - @item.votes

    if @item.destroy && @round.save
      render :status => 200, :json => { 'round' => @round, 'songs' => @items }
    end
  end
end
