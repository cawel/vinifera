class Wine < ActiveRecord::Base
  
  belongs_to :person
  belongs_to :category
  belongs_to :country
  belongs_to :region
  
  has_many :reviews, :dependent => :destroy
  has_many :variety_wines
  has_many :varieties, :through => :variety_wines
  
  validates_presence_of :name
  validates_presence_of :category_id
  validates_presence_of :person_id
  
end
