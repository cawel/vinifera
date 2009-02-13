require 'digest/sha1'

class Person < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :email, :name, :password, :password_confirmation



  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(email, password)
    return nil if email.blank? || password.blank?
    u = find_by_email(email) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end
  
  def self.find_by_valid_password_reset_code(code)
      u = find_by_password_reset_code(code)
      u.andand.password_reset_code_expires.andand.after?(Time.now) ? u : nil
    end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end


  def create_password_reset_code
    self[:password_reset_code]         = self.class.make_token
    self[:password_reset_code_expires] = 1.week.from_now
    save(false)
    
    PasswordResetMailer.deliver_password_reset(self)
  end
  
  def expire_password_reset_code
    self[:password_reset_code]         = nil
    self[:password_reset_code_expires] = nil
    save(false)
  end
  
  #needed by ActiveScaffold in order to have a proper label
  def is_admin?
    self.admin
  end

  protected
    


end
