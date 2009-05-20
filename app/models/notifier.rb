class Notifier < ActionMailer::Base

 default_url_options[:host] ||= "localhost:3000"  
   
  def password_reset_instructions(user)  
    subject       "Password Reset Instructions"  
    from          "OpenOverflow Notifier "  
    recipients    user.email  
    sent_on       Time.now  
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)  
  end    

end
