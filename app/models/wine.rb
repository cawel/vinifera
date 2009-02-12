class Wine < ActiveRecord::Base
  
  belongs_to :color
  belongs_to :person
  belongs_to :country
  
  has_many :reviews, :dependent => :destroy
  has_many :variety_wines
  has_many :varieties, :through => :variety_wines
  
  validates_presence_of :name
  validates_presence_of :color_id
  validates_presence_of :person_id
  
end