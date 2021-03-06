module AresMUSH
  module Login
    class RegisterRequestHandler
      def handle(request)
        recaptcha = AresMUSH::Website::RecaptchaHelper.new
        enable_registration = Global.read_config("login", "allow_web_registration")
        
        if (!enable_registration)
          return { message: t('login.web_registration_disabled') }
        end
              
        name = request.args[:name]
        pw = request.args[:password]
        confirm_pw = request.args[:confirm_password]
        recaptcha_response = request.args[:recaptcha]
      
        if (recaptcha.is_enabled? && !recaptcha.verify(recaptcha_response))
          return { error: t('login.recaptcha_failed') }
        end
      
        name_error = Character.check_name(name)
        password_error = Character.check_password(pw)
      
        if (pw != confirm_pw)
          return { error: t('login.passwords_dont_match') }
        elsif name_error
          return { error: name_error }
        elsif password_error
          return { error: password_error }
        end 
        char = Character.new
        char.name = name
        char.change_password(pw)
        char.room = Game.master.welcome_room
        char.login_api_token = Character.random_link_code
        char.login_api_token_expiry = Time.now + 86400
      
        if (Login.terms_of_service)
          char.update(terms_of_service_acknowledged: Time.now)
        end
        char.save
              
        Global.dispatcher.queue_event CharCreatedEvent.new(nil, char.id)
      
        {
          token: char.login_api_token,
          name: char.name,
          id: char.id
        }
      end
    end
  end
end