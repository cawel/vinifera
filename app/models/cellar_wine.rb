class CellarWine < ActiveRecord::Base
  belongs_to :wine
  belongs_to :person

  fires :cellar_wine_created, :on => :create, :actor => :person, :subject => :wine

  validates_uniqueness_of :wine_id, :scope => :person_id

  named_scope :for_person, lambda {|person| { :conditions => ['person_id = ?', person.id]}}
end
