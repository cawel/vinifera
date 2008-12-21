class VarietyWine < ActiveRecord::Base

  belongs_to :wine
  belongs_to :variety

end