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
      if @@count != @test.answers.count
        @@count = @test.answers.count
        @answers = @test.answers.build
        @questions = Question.find(@@question_order[@test.answers.count].to_i)
        @@option_order = [@questions.option_one, @questions.option_two, @questions.option_three, @questions.option_four]
        @@option_order = @@option_order.shuffle
        @options = @@option_order
      else
        @answers = @test.answers.build
        @questions = Question.find(@@question_order[@test.answers.count].to_i)
        @options = @@option_order
      end
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
      if !defined?(@@question_order)
        @@question_order = (1..20).to_a.shuffle
        @@count = -1
      end
    end
end
