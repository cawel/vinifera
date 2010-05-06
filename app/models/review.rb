class Review < ActiveRecord::Base
  fires :reviewed,  :on => :create, :actor => :person
  fires :edited,    :on => :update, :actor => :person

  belongs_to :wine
  belongs_to :person
  belongs_to :rating
  has_many :timeline_events, :foreign_key => 'subject_id', :dependent => :destroy

  validates_presence_of :rating_id
  validates_presence_of :person_id
  validates_presence_of :comment

  named_scope :for_person, lambda {|person| { :conditions => ['person_id = ?', person.id]}}

  named_scope :top_contributers,
    :select => "*, COUNT(*) AS review_count",
    :from => "people, reviews",
    :conditions => ['reviews.person_id = people.id'],
    :group => 'person_id',
    :order => 'review_count DESC'

end
