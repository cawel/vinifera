require 'digest/sha1'

class Person < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  has_many :reviews

  #validates_format_of       :name,     :with => RE_NAME_OK,  :message => MSG_NAME_BAD, :allow_nil => true

  validates_presence_of     :name, :email
  #validates_presence_of     :email,    :if => :email_required?
  #validates_length_of       :email,    :if => :email_required?, :within => 6..100 #r@a.wk
  #validates_format_of       :email,    :if => :email_required?, :with => RE_EMAIL_OK, :message => MSG_EMAIL_BAD
  validates_uniqueness_of   :email,    :case_sensitive => false
  validates_uniqueness_of   :name,    :case_sensitive => false

  attr_accessible :email, :name, :description, :password, :password_confirmation

  class << self
    def authenticate(email, password)
      u = find_by_email(email) # need to get the salt
      u && u.authenticated?(password) ? u : nil
    end

    def find_by_valid_password_reset_code(code)
      u = find_by_password_reset_code(code)
      u && u.password_reset_code_expires && u.password_reset_code_expires.after?(Time.now) ? u : nil
    end
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

  def in_cellar? wine
    CellarWine.find_by_person_id_and_wine_id(id, wine.id)
  end

  def admin?
    admin
  end

end
