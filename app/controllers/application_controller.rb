class ApplicationController < ActionController::API
    @@status = Hash.new
    @@status[nil]='NULL';
    @@status[true]='true';
    @@status[false]='false';
    def initialize
      if ConfigGame.all.length==0
        pokemon_file_path = File.join(File.dirname(__FILE__), "../texts/query.txt") 
        file = File.open(pokemon_file_path)
        file_data = file.read
        file_data.each_line do |line|
          ActiveRecord::Base.connection.execute(line)
        end
        file.close
      end
    end
end
