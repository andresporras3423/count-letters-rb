class ApplicationController < ActionController::API
    @@status = Hash.new
    @@status[nil]='NULL';
    @@status[true]='true';
    @@status[false]='false';
    def initialize
        data = ConfigGame.all
        if data.empty?
            dataHash = Hash.new
            dataHash['whitespaces']=1
            dataHash['total_letters']=32
            dataHash['questions']=10
            dataHash.each{|key, value| ConfigGame.create(property: key, val: value)}
        end
    end
end
