#if Rails.configuration.action_mailer.delivery_method == :smtp
  ActionMailer::Base.smtp_settings = {
    :enable_starttls_auto => false,
    :address        => "smtp.sendgrid.net",
    :port           => "25",
    :authentication => :plain,
    :user_name      => "ohavryl@gmail.com",
    :password       => "mailsender",
    :domain         => "worklex.com"
  }
#end
