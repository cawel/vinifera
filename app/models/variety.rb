class Variety < ActiveRecord::Base

  has_many :variety_wines
  has_many :wines, :through => :variety_wines

end
