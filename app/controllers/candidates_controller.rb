class CandidatesController < ApplicationController

    #使用 Model 的 all 類別方法，並存成 @candidates 實體變數
    #因為要在 View 使⽤ @candidates 變數所以才使⽤實體變數
    def index
        @candidates = Candidate.all                 
    end

    def new
        @candidate = Candidate.new
    end

    def create
        @candidate = Candidate.new(candidate_params)

        if @candidate.save
            #成功
            redirect_to candidates_path, notice: "新增候選⼈成功!"
        else
            #失敗
            render :new
        end
    end

    def edit
        @candidate = Candidate.find_by(id: params[:id])
    end

    def update
        @candidate = Candidate.find_by(id: params[:id])
        if @candidate.update(candidate_params)
            # 成功
            redirect_to candidates_path, notice: "資料更新成功!"
        else
            # 失敗
            render :edit
        end
    end

    def destroy
        @candidate = Candidate.find_by(id: params[:id])
        @candidate.destroy if @candidate
        redirect_to candidates_path, notice: "候選⼈資料已刪除!"
    end

    def vote
        @candidate = Candidate.find_by(id: params[:id])
        @candidate.vote_logs.create(ip_address: request.remote_ip) if @candidate
        redirect_to candidates_path, notice: "完成投票!"
    end

    private
    def candidate_params
        params.require(:candidate).permit(:name, :age, :party, :politics)
    end

end
