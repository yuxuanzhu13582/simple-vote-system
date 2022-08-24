class ApplicationController < ActionController::Base

    #只要在所有的 Controller 發⽣ ActiveRecord::RecordNotFound 例外
    #就會在畫⾯上印出⼀個「查無資料」的字樣，並且設定 HTTP 狀態為 404

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    private
    def record_not_found
        render plain: "查無資料", status: 404
    end

end
