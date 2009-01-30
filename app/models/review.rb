class Review < ActiveRecord::Base
  cattr_accessor :current_user
  
  belongs_to :wine
  belongs_to :person
  belongs_to :rating

  validates_presence_of :rating

  def authorized_for_update?
    Thread.current["Review.current_user"] == person
  end
  
end