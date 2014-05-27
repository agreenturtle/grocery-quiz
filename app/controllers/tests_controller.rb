class TestsController < ApplicationController
  before_action :set_question_order, only: [:show]
  http_basic_authenticate_with name: "James", password: "secret", only: :index
  
  def index
    @tests = Test.all
  end
  
  def show
    @test = Test.find(params[:id])
    if @test.answers.count == 20
      render "completed"
    else
      @start_time = session[:start_time]
      time = Time.new
      @current_time = time.strftime("%H:%M:%S")
      if session[:count] != @test.answers.count
        session[:count] = @test.answers.count
        @answers = @test.answers.build
        @questions = Question.find(session[:question_order][@test.answers.count].to_i)
        session[:option_order] = [@questions.option_one, @questions.option_two, @questions.option_three, @questions.option_four]
        @options = session[:option_order].shuffle
      else
        @answers = @test.answers.build
        @questions = Question.find(session[:question_order][@test.answers.count].to_i)
        @options = session[:option_order]
      end
    end
  end
  
  def new
    session[:question_order] = nil
    @test = Test.new
  end
  
  def create
    @test = Test.new
    @test.save
    redirect_to @test
  end
  
  private
    def set_question_order
      @test = Test.find(params[:id])
      if session[:question_order].nil?
        session[:question_order] = (1..20).to_a.shuffle
        session[:count] = -1
        time = Time.new
        session[:start_time] = time.strftime("%H:%M:%S")
      end
    end
end
