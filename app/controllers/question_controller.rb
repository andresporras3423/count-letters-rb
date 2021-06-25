class QuestionController < ApplicationController
    def save
        nQuestion = Question.create(letter: params[:letter], correct: @@status[params[:correct]])
        if nQuestion.valid?
            nQuestion.save
            head(:created)
        else
            head(:bad_request)
        end
    end

    def show_recent
        nQuestions = Question.where("correct=#{params[:correct]}").order("created_at").limit(10)
        render json: nQuestions.as_json(only: %i[letter created_at]), status: :ok
    end

    def show_top
        sql = """
        with q1 as (select letter,
            count(*) as total,
            sum(case
            when correct=#{params[:correct]}
            then 1
            else 0
            end) as corrects
            from questions
            group by letter)
            select letter, cast(corrects*100.0/total as decimal(18,2)) as percentaje, total, corrects
            from q1
            order by percentaje desc, total desc limit 10;
        """;
        top_questions = ActiveRecord::Base.connection.execute(sql)
        render json: top_questions, status: :ok
    end
end
