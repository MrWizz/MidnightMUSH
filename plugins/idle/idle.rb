$:.unshift File.dirname(__FILE__)

module AresMUSH
  module Idle
    def self.plugin_dir
      File.dirname(__FILE__)
    end
 
    def self.shortcuts
      Global.read_config("idle", "shortcuts")
    end
 
    def self.load_plugin
      self
    end
 
    def self.unload_plugin
    end
 
    def self.config_files
      [ "config_idle.yml"]
    end
    
    def self.locale_files
      [ "locales/locale_en.yml" ]
    end
 
    def self.get_cmd_handler(client, cmd, enactor)
      case cmd.root
      when "idle"
        case cmd.switch
        when "action", "gone", "npc", "dead", "warn", "roster"
          return IdleActionCmd
        when "execute"
          return IdleExecuteCmd
        when "queue", nil
          return IdleQueueCmd
        when "remove"
          return IdleRemoveCmd
        when "set"
          return IdleSetCmd
        when "start"
          return IdleStartCmd
        end
      when "lastwill"
        return LastWillCmd
      when "roster"
        case cmd.switch
        when "add"
          return RosterAddCmd
        when "claim"
          return RosterClaimCmd
        when "note", "contact", "played"
          return RosterDataCmd
        when "remove"
          return RosterRemoveCmd
        when "restrict"
          return RosterRestrictCmd
        when nil
          if (cmd.args)
            return RosterViewCmd
          else
            return RosterListCmd
          end
        end
      end
       
      nil
    end

    def self.get_event_handler(event_name) 
      case event_name
      when "CharConnectedEvent"
        return CharConnectedEventHandler
      when "CronEvent"
        return CronEventHandler
      end
      nil
    end
  end
end
