class TestsController < ApplicationController
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
    end
    @questions = Question.find(@test.answers.count+1)
    @options = [@questions.option_one, @questions.option_two, @questions.option_three, @questions.option_four]
    @options = @options.shuffle
  end
  
  def new
    @test = Test.new
  end
  
  def create
    @test = Test.new
    @test.save
    redirect_to @test
  end
end
