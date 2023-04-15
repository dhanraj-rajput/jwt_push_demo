class PrintJob
  include Sidekiq::Job

  def perform(*args)
    UserMailer.welcome_message.deliver_now
  end
end
