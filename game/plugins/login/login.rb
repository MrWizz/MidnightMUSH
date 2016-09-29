$:.unshift File.dirname(__FILE__)
load "lib/alias_cmd.rb"
load "lib/connect_cmd.rb"
load "lib/create_cmd.rb"
load "lib/email_set_cmd.rb"
load "lib/email_view_cmd.rb"
load "lib/helpers.rb"
load "lib/last_cmd.rb"
load "lib/login_events.rb"
load "lib/login_model.rb"
load "lib/password_reset_cmd.rb"
load "lib/password_set_cmd.rb"
load "lib/quit_cmd.rb"
load "lib/tos_cmd.rb"
load "lib/tour_cmd.rb"
load "lib/watch_cmd.rb"
load "login_events.rb"
load "login_api.rb"

module AresMUSH
  module Login
    def self.plugin_dir
      File.dirname(__FILE__)
    end
 
    def self.shortcuts
      Global.read_config("login", "shortcuts")
    end
 
    def self.load_plugin
      self
    end
 
    def self.unload_plugin
    end
 
    def self.help_files
      [ "help/admin_login.md", "help/email.md", "help/last.md", "help/login.md", "help/names.md", "help/watch.md" ]
    end
 
    def self.config_files
      [ "config_login.yml" ]
    end
 
    def self.locale_files
      [ "locales/locale_en.yml" ]
    end
 
    def self.get_cmd_handler(client, cmd, enactor)
      case cmd.root
      when "alias"
        return AliasCmd
      when "create"
        return CreateCmd
      when "email"
        case cmd.switch
        when "set"
          return EmailSetCmd
        when nil
          return EmailViewCmd
        end
      when "last"
        return LastCmd
      when "password"
        case cmd.switch
        when "reset"
          return PasswordResetCmd
        when nil
          return PasswordSetCmd
        end
      when "quit"
        return QuitCmd
      when "tos"
        case cmd.switch
        when "agree"
          return TosCmd
        end
      when "tour"
        return TourCmd
      when "connect"
        return ConnectCmd
      when "watch"
        return WatchCmd
      end
         
      # Special check to allow 'c' to be used for tour or connect when not logged in.
      if (!client.logged_in?)
        if (cmd.root_is?("c") && cmd.args)
          if (cmd.args.start_with?("guest"))
            return TourCmd
          else
            return ConnectCmd
          end
        end
      end
      nil
    end

    def self.get_event_handler(event_name)      
      case event_name
      when "CharCreatedEvent"
        return CharCreatedEventHandler
      when "CharConnectedEvent"
        return CharConnectedEventHandler
      when "CharDisconnectedEvent"
        return CharDisconnectedEventHandler      
      end
      nil
    end
  end
end