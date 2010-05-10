class ActionView::Base
  include ApplicationHelper
end

class PasswordResetMailer < ActionMailer::Base

  def self.configure(request)
    self.default_url_options[:host] = request.host
    self.default_url_options[:port] = request.port unless request.port == 80
    self.default_url_options[:protocol] = request.protocol
  end

  def password_reset(person)
    recipients [person.email]
    from       "Le-Tastevin <info@le-tastevin.com>" 
    subject    "Instructions pour reinitialiser le mot de passe" 
    body       :person => person
  end
end
