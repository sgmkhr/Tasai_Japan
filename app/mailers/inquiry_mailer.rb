class InquiryMailer < ApplicationMailer
  
  def send_mail(inquiry)
    @inquiry = inquiry
    mail to: ENV['TOMAIL'], subject: @contact.subject_i18n
  end
  
end
