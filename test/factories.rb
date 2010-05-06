Factory.sequence :name do |n|
  "Name #{n}"
end

Factory.sequence :code_saq do |n|
  "SAQ #{n}"
end

Factory.sequence :email do |n|
  "name#{n}@host.com"
end

Factory.sequence :open_id_url do |n|
  "http://openid#{n}.factory.com"
end

Factory.define :person do |p|
  p.name                  { Factory.next :name }
  p.email                 { Factory.next :email }
  p.password              "monkey"
  p.password_confirmation "monkey"
end

Factory.define :person_with_open_id, :parent => :person do |p|
  p.open_id_url               { Factory.next :open_id_url }
  p.open_id_url_authenticated true
end

Factory.define :remembered_person, :parent => :person do |p|
  p.remember_token            { Person.make_token }
  p.remember_token_expires_at 10.days.from_now
end

Factory.define :color do |c|
end

Factory.define :country do |c|
end

Factory.define :category do |c|
end

Factory.define :nature do |c|
end

Factory.define :wine do |w|
  w.name 'wine name'
  w.association :color, :factory => :color
  w.association :country, :factory => :country
  w.association :category, :factory => :category
  w.association :nature, :factory => :nature
  w.provider 'wine provider'
  w.code_saq {Factory.next :code_saq}
end


Factory.define :cellar_wine do |c|
  c.association :wine, :factory => :wine
  c.association :person, :factory => :person
end

#Factory.define :review do |r|
  #r.rating_id  1
  #r.comment  "my review"
  #r.association :person, :factory => :person
#end
