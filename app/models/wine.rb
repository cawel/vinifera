class Wine < ActiveRecord::Base
  has_many :reviews, :dependent => :destroy
  belongs_to :color
  has_many :variety_wines
  has_many :varieties, :through => :variety_wines

  validates_presence_of :name
  validates_presence_of :color_id
  
end