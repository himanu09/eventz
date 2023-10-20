class UserMailer < ApplicationMailer

  default from: email_address_with_name('notification.events@himanu.com', 'Events Notifications')

  def welcome_email
    attachments.inline['krishna.png'] = File.read('/home/user60/Downloads/krishna.png')
    @user = params[:user]
    @url  = 'https://in.linkedin.com/in/hhimanshurajore'
    mail(
      to: email_address_with_name(@user.email, @user.name),
      subject: 'Welcome to My Awesome Site'
    )
  end

  def registration_email
    @user = params[:user]
    @registration = params[:registration]
    @registrations = @user.registrations
    mail(
      to: email_address_with_name(@user.email, @user.name),
      subject: 'Thanks For Registering in the Event'
    )
  end

end
