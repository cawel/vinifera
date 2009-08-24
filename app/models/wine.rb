class Wine < ActiveRecord::Base
  
  belongs_to :person
  belongs_to :category
  belongs_to :country
  belongs_to :region
  belongs_to :sub_region
  belongs_to :color
  belongs_to :nature
  belongs_to :appellation
  
  has_many :reviews, :dependent => :destroy
  has_many :variety_wines
  has_many :varieties, :through => :variety_wines
  
  # those are the fields always present on the SAQ website
  validates_presence_of :name
  validates_presence_of :category_id
  validates_presence_of :color_id
  validates_presence_of :nature_id
  validates_presence_of :country_id

  validates_presence_of :person_id
  
end
