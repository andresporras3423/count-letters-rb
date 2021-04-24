class ConfigGameController < ApplicationController
    def get
        data = ConfigGame.all
        render json: data.as_json(only: %i[property val]), status: :ok
    end

    def update
        data = ConfigGame.where("property='#{params[:property]}'").limit(1).first
        if data.nil?
            head(:not_found)
        else
            data.val = params[:val]
            data.save
            head(:ok)
        end
    end
end
