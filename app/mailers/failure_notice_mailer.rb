class FailureNoticeMailer < ApplicationMailer
  default from: 'masanomaildesu@gmail.com'

  def send_failure_notice(url, email) #get parameter from tasks
    @monitoring_url = url
    user_email = email
    mail(to: user_email, subject: 'Website Tracker failure notice')
  end

end