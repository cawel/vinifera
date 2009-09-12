class Review < ActiveRecord::Base
  fires :reviewed,  :on => :create, :actor => :person
  fires :edited,    :on => :update, :actor => :person
  
  belongs_to :wine
  belongs_to :person
  belongs_to :rating
  
  validates_presence_of :rating_id
  validates_presence_of :person_id
  validates_presence_of :comment
end
