class CandidatesController < ApplicationController
    
    # layout "backend"              #套用 backend 版型

    before_action :find_candidate, only: [:edit, :update, :destroy, :vote]

    #使用 Model 的 all 類別方法，並存成 @candidates 實體變數
    #因為要在 View 使⽤ @candidates 變數所以才使⽤實體變數
    def index
        # @candidates = Candidate.all                           #desplay all candidates
        # @candidates = Candidate.all.where("age > 18")         #desplay cadidates with age > 18 
        @candidates = Candidate.all.order(age: :desc)
        # render layout: "backend"          # index Action 套用 backend 版型(投票時會出錯!!!)         
    end

    def new
        @candidate = Candidate.new
        # render layout: "backend"
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
        # @candidate = Candidate.find_by(id: params[:id])               #because of having before_action
    end

    def update
        # @candidate = Candidate.find_by(id: params[:id])               #because of having before_action
        if @candidate.update(candidate_params)
            # 成功
            redirect_to candidates_path, notice: "資料更新成功!"
        else
            # 失敗
            render :edit
        end
    end

    def destroy
        # @candidate = Candidate.find_by(id: params[:id])               #because of having before_action
        @candidate.destroy if @candidate
        redirect_to candidates_path, notice: "候選⼈資料已刪除!"
    end

    def vote
        # @candidate = Candidate.find_by(id: params[:id])               #because of having before_action
        @candidate.vote_logs.create(ip_address: request.remote_ip) if @candidate
        redirect_to candidates_path, notice: "完成投票!"
    end

    private
    def candidate_params
        params.require(:candidate).permit(:name, :age, :party, :politics)
    end

    def find_candidate
        # @candidate = Candidate.find_by(id: params[:id])        # find_by 方法查詢，如果查不到僅是回傳 nil 物件

        #當 find ⽅法查不到資料、發⽣例外訊息，就會進⾏ rescue 路線
        begin
            @candidate = Candidate.find(params[:id])
        rescue
            redirect_to candidate_path, notice: "查無此候選人"
        end
    end

end
