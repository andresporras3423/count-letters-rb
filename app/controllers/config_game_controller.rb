class ConfigGameController < ApplicationController
    def get
        data = ConfigGame.all
        if data.empty?
            dataHash = Hash.new
            dataHash['whitespaces']=1
            dataHash['total_letters']=32
            dataHash['questions']=10
            dataHash.each{|key, value| ConfigGame.create(property: key, val: value)}
            data = ConfigGame.all
        end
        render json: data.as_json(only: %i[property val]), status: :ok
    end
end
