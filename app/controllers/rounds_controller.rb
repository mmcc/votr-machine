class RoundsController < ApplicationController

	# GET /rounds
  def index
  end

  # GET /rounds/:id
  def show
  	@round = Round.includes(:items).find(params[:id])
  	@timer = @round.end_time - DateTime.now.to_i
  	@msg = { :items => @round.items, :round => @round, :total_votes => @round.total_votes }.to_json
  end

  # POST /rounds/:id/:item_id
	def vote
		@round = Round.find(params[:id])
		unless @round.end_time.past?
			@items = @round.items.order("title")
			@item = @items.find(params[:item_id])
			@item.votes = @item.votes + 1
			@round.total_votes = @round.total_votes + 1

			if @item.save and @round.save
        @items = Round.find(params[:id]).items
        puts "Total votes: #{@round.total_votes}"

        publish = PUBNUB.publish({
          'channel' => @round.channel,
          'message' => { 'total_votes' => @round.total_votes, 'items' => @items },
          'callback' => lambda do |message|
            puts message
          end
        })

        render :status => 200, :json => { 'round' => @round, 'songs' => @songs }
      end
    end
  end

end
