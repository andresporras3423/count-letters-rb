class QuestionController < ApplicationController
    def save
        nQuestion = Question.create(letter: params[:letter], correct: params[:correct])
        if nQuestion.valid?
            nQuestion.save
            head(:created)
        else
            head(:bad_request)
        end
    end

    def show_recent
        nQuestions = Question.where("correct=#{@@status[params[:correct]]}").order("created_at").limit(10)
        render json: nQuestions.as_json(only: %i[letter created_at]), status: :ok
    end
end
