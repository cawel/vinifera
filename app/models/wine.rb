class Wine < ActiveRecord::Base

  belongs_to :person
  belongs_to :category
  belongs_to :color
  belongs_to :nature
  belongs_to :flavor
  belongs_to :country
  belongs_to :appellation
  belongs_to :region
  belongs_to :sub_region

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

  cattr_reader :per_page
  @@per_page = 20

  define_index do
    # fields
    indexes name, :sortable => true

    # attributes
    # has author_id, created_at, updated_at
  end


end
