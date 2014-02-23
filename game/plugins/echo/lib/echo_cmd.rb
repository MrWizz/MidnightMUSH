module AresMUSH
  module Echo
    class EchoCmd
      include AresMUSH::Plugin

      def want_command?(client, cmd)
        cmd.root_is?("echo") || cmd.root_is?("think")
      end
      
      def handle
        client.emit cmd.args
      end
    end
  end
end