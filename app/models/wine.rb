class Wine < ActiveRecord::Base
  has_many :reviews, :dependent => :destroy
  belongs_to :color
  belongs_to :variety

  validates_presence_of :name
  validates_presence_of :color_id
  
end