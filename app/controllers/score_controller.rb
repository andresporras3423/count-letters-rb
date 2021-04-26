class ScoreController < ApplicationController
    def save
        configData = ConfigGame.all 
        configHash = Hash.new
        configData.each{|c| configHash[c.property]=c.val}
        nScore = Score.create(questions: configHash['questions'], letters: configHash['total_letters'], seconds: params[:seconds], corrects: params[:corrects])
        if nScore.valid?
            nScore.save
            head(:created)
        else
            head(:bad_request)
        end
    end
end
