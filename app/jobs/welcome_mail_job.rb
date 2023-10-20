class WelcomeMailJob < ApplicationJob
  queue_as :default

  def perform(user)
    # WelcomeMailJob.perform_later
    UserMailer.with(user: user).welcome_email.deliver_now
  end
end
