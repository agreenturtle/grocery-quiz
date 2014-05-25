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
      @answers = @test.answers.build
      @questions = Question.find(@@question_order[@test.answers.count].to_i)
      @options = [@questions.option_one, @questions.option_two, @questions.option_three, @questions.option_four]
      @options = @options.shuffle
    end
  end
  
  def new
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
      if @test.answers.count == 0
        @@question_order = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20].shuffle
      end
    end
end
