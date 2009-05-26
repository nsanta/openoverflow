# == Schema Information
# Schema version: 20090424001630
#
# Table name: votes
#
#  id            :integer         not null, primary key
#  vote          :integer
#  voteable_type :string(255)
#  voteable_id   :integer
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Vote < ActiveRecord::Base
  VOTE_RANGE = [-1 , 1]

  belongs_to :user
  
  belongs_to :voteable , :polymorphic => true
  
  # == Validations
  validates_presence_of :vote , :voteable , :user
  validates_inclusion_of :vote, :in => VOTE_RANGE
  validates_uniqueness_of :user_id  , :scope => [:voteable_id , :voteable_type]
  
  # == Callbacks
  after_create do |record| 
    record.vote_averages_of_voteables_on_create
    record.update_user_counter_caches_on_create
    record.add_points(10)
  end  
  after_update do |record| 
    record.vote_averages_of_voteables_on_update
    record.update_user_counter_caches_on_update
    record.add_points(-10)
  end  
  
  
  #== Instance Methods
  def vote_averages_of_voteables_on_create
    self.voteable.votes_average += self.vote
    self.voteable.save
  end

  def vote_averages_of_voteables_on_update
    self.voteable.votes_average += self.vote * 2
    self.voteable.save
  end
 
  def update_user_counter_caches_on_create
    if vote == 1
      self.user.total_votes_up += 1
    elsif vote == -1
      self.user.total_votes_down += 1
    end
    self.user.total_votes += 1
    self.user.save
  end
  
  def update_user_counter_caches_on_create
    if vote == 1
      self.user.total_votes_up += 1
      self.user.total_votes_down -= 1
    elsif vote == -1
      self.user.total_votes_down += 1
      self.user.total_votes_up -= 1
    end
    self.user.save
  end
  
  def add_points(points = 1)
    self.user.total_points ||= 0
    self.user.total_points += points
    self.user.save
  end
  
end
