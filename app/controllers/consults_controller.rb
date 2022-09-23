class ConsultsController < ApplicationController
  def index
    @question = Question.new
    @questions = Question.order('created_at DESC').all.page( params[:page]).per( Setting.systems.per_page )
  end

   
  def create
    ip = request.remote_ip
    questions = Question.where(:ip => ip, :search_date => Date.today)

    if questions.size < 2 
      @question = Question.new(question_params)
      @question.ip = ip 
      @question.search_date = Date.today 
      @question.save
    end

    redirect_to :action => :index
  end
   
  private
    def question_params
      params.require(:question).permit( :title, :content)
    end
end
