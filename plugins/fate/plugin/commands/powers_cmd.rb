module AresMUSH    
  module Fate
    class PowersCmd
      include CommandHandler
  
      def handle
      
        powers = Global.read_config("fate", "powers")
        list = powers.sort_by { |s| s['name']}
                    .map { |s| "%xh#{s['name']}%xn - #{s['description']}" }
                    
        template = BorderedPagedListTemplate.new list, cmd.page, 25, t('fate.powers_title')
        client.emit template.render
      end
    end
  end
end