require File.dirname(__FILE__) + '/../helper'

RE_Person      = %r{(?:(?:the )? *(\w+) *)}
RE_Person_TYPE = %r{(?: *(\w+)? *)}
steps_for(:person) do

  #
  # Setting
  #
  
  Given "an anonymous person" do 
    log_out!
  end

  Given "$an $person_type person with $attributes" do |_, person_type, attributes|
    create_person! person_type, attributes.to_hash_from_story
  end
  
  Given "$an $person_type person named '$login'" do |_, person_type, login|
    create_person! person_type, named_person(login)
  end
  
  Given "$an $person_type person logged in as '$login'" do |_, person_type, login|
    create_person! person_type, named_person(login)
    log_in_person!
  end
  
  Given "$actor is logged in" do |_, login|
    log_in_person! @person_params || named_person(login)
  end
  
  Given "there is no $person_type person named '$login'" do |_, login|
    @person = Person.find_by_login(login)
    @person.destroy! if @person
    @person.should be_nil
  end
  
  #
  # Actions
  #
  When "$actor logs out" do 
    log_out
  end

  When "$actor registers an account as the preloaded '$login'" do |_, login|
    person = named_person(login)
    person['password_confirmation'] = person['password']
    create_person person
  end

  When "$actor registers an account with $attributes" do |_, attributes|
    create_person attributes.to_hash_from_story
  end
  

  When "$actor logs in with $attributes" do |_, attributes|
    log_in_person attributes.to_hash_from_story
  end
  
  #
  # Result
  #
  Then "$actor should be invited to sign in" do |_|
    response.should render_template('/sessions/new')
  end
  
  Then "$actor should not be logged in" do |_|
    controller.logged_in?.should_not be_true
  end
    
  Then "$login should be logged in" do |login|
    controller.logged_in?.should be_true
    controller.current_person.should === @person
    controller.current_person.login.should == login
  end
    
end

def named_person login
  person_params = {
    'admin'   => {'id' => 1, 'login' => 'addie', 'password' => '1234addie', 'email' => 'admin@example.com',       },
    'oona'    => {          'login' => 'oona',   'password' => '1234oona',  'email' => 'unactivated@example.com'},
    'reggie'  => {          'login' => 'reggie', 'password' => 'monkey',    'email' => 'registered@example.com' },
    }
  person_params[login.downcase]
end

#
# Person account actions.
#
# The ! methods are 'just get the job done'.  It's true, they do some testing of
# their own -- thus un-DRY'ing tests that do and should live in the person account
# stories -- but the repetition is ultimately important so that a faulty test setup
# fails early.  
#

def log_out 
  get '/sessions/destroy'
end

def log_out!
  log_out
  response.should redirect_to('/')
  follow_redirect!
end

def create_person(person_params={})
  @person_params       ||= person_params
  post "/people", :person => person_params
  @person = Person.find_by_login(person_params['login'])
end

def create_person!(person_type, person_params)
  person_params['password_confirmation'] ||= person_params['password'] ||= person_params['password']
  create_person person_params
  response.should redirect_to('/')
  follow_redirect!

end



def log_in_person person_params=nil
  @person_params ||= person_params
  person_params  ||= @person_params
  post "/session", person_params
  @person = Person.find_by_login(person_params['login'])
  controller.current_person
end

def log_in_person! *args
  log_in_person *args
  response.should redirect_to('/')
  follow_redirect!
  response.should have_flash("notice", /Logged in successfully/)
end
