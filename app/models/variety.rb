class Variety < ActiveRecord::Base
  has_many :wines, :through => :variety_wines

end
