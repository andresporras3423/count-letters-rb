class ScoreController < ApplicationController
    def save
        configHash = ConfigGame.all.to_h{|c| [c.property, c.val]}
        nScore = Score.create(questions: configHash['questions'], letters: configHash['total_letters'], seconds: params[:seconds], corrects: params[:corrects])
        if nScore.valid?
            nScore.save
            head(:created)
        else
            head(:bad_request)
        end
    end

    def show_recent
        configHash = ConfigGame.all.to_h{|c| [c.property, c.val]}
        nScores = Score.where("questions=#{configHash['questions']} and letters=#{configHash['total_letters']}").order("created_at").limit(10)
        render json: nScores, status: :ok
    end

    def show_top
        configHash = ConfigGame.all.to_h{|c| [c.property, c.val]}
        sql = """
        select (seconds*POWER(2,questions-corrects)) as score, 
            questions, corrects, seconds, created_at from scores 
            where questions=#{configHash['questions']} and letters=#{configHash['total_letters']}
            order by (seconds*POWER(2,questions-corrects)), corrects limit 10;
        """;
        top_scores = ActiveRecord::Base.connection.execute(sql)
        render json: top_scores, status: :ok
    end
end
