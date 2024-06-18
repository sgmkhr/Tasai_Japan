class Public::InquiriesController < ApplicationController
  
  def new
    @inquiry = Inquiry.new
  end

  def confirm # 入力内容確認画面 newからデータを受け取る
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.invalid?
      render :new
    end
  end
　
  def back # 入力内容を保持したまま入力画面に戻れるようにする
    @inquiry = Inquiry.new(inquiry_params)
    render :new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.send_mail(@inquiry).deliver_now
      redirect_to inquiry_done_path
    else
      flash.now[:alert] = I18n.t('inquiries.send_failed')
      render :new
    end
  end

  def done # 送信完了表示画面
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :name, :phone_number, :subject, :body)
  end
  
end
