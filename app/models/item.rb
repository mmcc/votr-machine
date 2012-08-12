class Item < ActiveRecord::Base
  attr_accessible :percentage, :round_id, :title, :votes

  belongs_to :round

  before_save :recalculate_percentage

  private
  	def recalculate_percentage
  		self.percentage = self.votes.to_f / round.total_votes.to_f
  	end
end