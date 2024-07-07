class InquiryMailer < ApplicationMailer
  def send_mail(inquiry)
    @inquiry = inquiry
    mail to: ENV["TOMAIL"], subject: @inquiry.subject_i18n
  end
end
