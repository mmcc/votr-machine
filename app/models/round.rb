class Round < ActiveRecord::Base
  attr_accessible :end_time, :start_time, :total_votes

  has_many :items

  belongs_to :user

  before_create :generate_channel

  scope :current, lambda { 
    where("start_time <= ? and end_time > ?", DateTime.now, DateTime.now)
  }

  scope :past, lambda {
  	where("end_time < ?", DateTime.now)
  }

  scope :upcoming, lambda {
  	where("start_time > ?", DateTime.now)
  }

  private
 		def generate_channel
 			self.channel = SecureRandom.hex(12)
 		end
end
