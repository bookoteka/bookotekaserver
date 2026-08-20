class ApplicationMailer < ActionMailer::Base
  default from: ENV['INTERIA_EMAIL']
  layout 'mailer'
end