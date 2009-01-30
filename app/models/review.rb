class Review < ActiveRecord::Base
  
  belongs_to :wine
  belongs_to :person
  belongs_to :rating

  validates_presence_of :rating

end