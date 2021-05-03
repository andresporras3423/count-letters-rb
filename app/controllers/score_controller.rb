class ScoreController < ApplicationController
    def save
        configHash = ConfigGame.all.to_h{|c| [c.property, c.val]}
        nScore = Score.create(questions: configHash['questions'], letters: configHash['total_letters'], seconds: params[:seconds], corrects: params[:corrects])
        if nScore.valid?
            nScore.save
            render json: {'id': nScore.id}, status: :created
        else
            head(:bad_request)
        end
    end

    def show_recent
        configHash = ConfigGame.all.to_h{|c| [c.property, c.val]}
        sql = """
        select (seconds*POWER(2,questions-corrects)) as score, 
            questions, corrects, seconds, created_at from scores 
            where questions=#{configHash['questions']} and letters=#{configHash['total_letters']}
            order by created_at desc limit 10;
        """;
        top_scores = ActiveRecord::Base.connection.execute(sql)
        render json: nScores, status: :ok
    end

    def show_top
        configHash = ConfigGame.all.to_h{|c| [c.property, c.val]}
        sql = """
        select (seconds*POWER(2,questions-corrects)) as score, 
            questions, corrects, seconds, created_at from scores 
            where questions=#{configHash['questions']} and letters=#{configHash['total_letters']}
            order by (seconds*POWER(2,questions-corrects)), corrects desc, seconds limit 10;
        """;
        top_scores = ActiveRecord::Base.connection.execute(sql)
        render json: top_scores, status: :ok
    end

    def show_position
        sql = """
        select num from 
            (select id, ROW_NUMBER() OVER(partition by questions, letters order by seconds*POWER(2,questions-corrects)) as num 
            from scores) as sorted where id=#{params[:id]};
        """;
        position = ActiveRecord::Base.connection.execute(sql)
        render json: position, status: :ok
    end
end
