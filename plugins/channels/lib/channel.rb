module AresMUSH
  class Channel < Ohm::Model
    include ObjectModel
    include FindByName
    
    attribute :name
    attribute :name_upcase
    attribute :color, :default => "%xh"
    attribute :description
    attribute :announce, :type => DataType::Boolean, :default => true
    attribute :default_alias, :type => DataType::Array
    attribute :messages, :type => DataType::Array, :default => []
    attribute :recall_enabled, :type => DataType::Boolean, :default => true
    
    index :name_upcase
    
    set :roles, "AresMUSH::Role"
    set :characters, "AresMUSH::Character"

    before_save :save_upcase
    
    def save_upcase
      self.name_upcase = self.name.upcase
      
      if (!self.default_alias)
        aliases = []
        if (self.name.length >= 3)
          aliases << self.name[0..2].strip.downcase 
        end
        if (self.name.length >= 2)
          aliases << self.name[0..1].strip.downcase
        end
        self.default_alias = aliases.uniq
      end
    end      
        
    def display_name(include_markers = true)
      display = "#{self.color}#{self.name}%xn"
      include_markers ? Channels.name_with_markers(display) : display
    end
    
    def add_to_history(msg)
      return if !self.recall_enabled
      new_messages = (self.messages << msg)
      if (new_messages.count > 25)
        new_messages.shift
      end
      self.update(messages: new_messages)
    end      
    
    def self.find_one_with_partial_match(name)
      channel = Channel.find_one_by_name(name)
      
      if (!channel)
        possible_matches = Channel.all.select { |c| c.name_upcase.starts_with?(name.upcase) }
        if (possible_matches.count == 1)
          channel = possible_matches.first
        end
      end
      
      channel
    end
  end
end
