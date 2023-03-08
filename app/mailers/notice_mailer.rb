class NoticeMailer < ApplicationMailer
  def send_mail(title, content, group_users)
    @title = title
    @content = content
    mail bcc: group_users.pluck(:email), subject: title
  end
end
