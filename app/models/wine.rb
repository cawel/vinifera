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

  validates_uniqueness_of :code_saq, :scope => :year

  cattr_reader :per_page
  @@per_page = 20

  # this is bullshit (what I really need is a wines.weighted_rating)
  named_scope :top_wines,
    :select => "wines.*, count(*) as review_count",
    :from => "wines, reviews, ratings",
    :conditions => ["wines.id = reviews.wine_id and reviews.rating_id = ratings.id"],
    :group => "wine_id",
    :order => "ratings.name desc, review_count desc",
    :limit => 5

  # otherwise it messes up associations in fixtures
  unless RAILS_ENV == 'test'
    define_index do
      # fields
      indexes name, :sortable => true
      indexes code_saq, :sortable => true

      # attributes
      # has author_id, created_at, updated_at
    end
  end


end
