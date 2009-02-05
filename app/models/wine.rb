class Wine < ActiveRecord::Base
  
  has_many :reviews, :dependent => :destroy
  belongs_to :color
  belongs_to :person
  has_many :variety_wines
  has_many :varieties, :through => :variety_wines
  
  validates_presence_of :name
  validates_presence_of :color_id
  validates_presence_of :person_id
  
end