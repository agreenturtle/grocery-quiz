class TestsController < ApplicationController
  before_action :init_start_time, only: [:show]
  http_basic_authenticate_with name: "James", password: "secret", only: :index
  
  def index
    @tests = Test.all
    @tests.each do |test|
      test.total_questions_answered = test.answers.count
      if test.finished_time.nil?
        test.time_taken = "02:00"
      else
        test.time_taken = calculate_time_taken(test)
      end
    end
  end
  
  def show
    @test = Test.find(params[:id])
    if @test.answers.count == 20
      time = Time.new
      @test.finished_time = time.strftime("%H:%M:%S")
      render "completed"
    end
    
    #else
    #  @start_time = session[:start_time]
    #  time = Time.new
    #  @current_time = time.strftime("%H:%M:%S")
    #  if session[:count] != @test.answers.count
    #    session[:count] = @test.answers.count
    #    @answers = @test.answers.build
    #    @questions = Question.find(session[:question_order][@test.answers.count].to_i)
    #    session[:option_order] = [@questions.option_one, @questions.option_two, @questions.option_three, @questions.option_four]
    #    @options = session[:option_order].shuffle
    #  else
    #    @answers = @test.answers.build
    #    @questions = Question.find(session[:question_order][@test.answers.count].to_i)
    #    @options = session[:option_order]
    #  end
    #end
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
    def init_start_time
      @test = Test.find(params[:id])
      if session[:question_order].nil?
        time = Time.new
        session[:start_time] = time.strftime("%H:%M:%S")
        @test.start_time = session[:start_time]
      end
    end
    
    def calculate_time_taken(test)
      time_taken = convert_to_seconds(test.finished_time) - convert_to_seconds(test.start_time)
      if time_taken > 60
        mins = "01"
        secs = time_taken - 60
        return mins << ':' << secs.to_s
      elsif time_taken < 60
        return "00:" << time_taken.to_s
      else #time_taken == 60
        return "01:00"
      end
    end
    
    def convert_to_seconds(time)
      parts = time.split(':')
      hours = parts[0].to_i * 3600
      mins = parts[1].to_i * 60
      secs = parts[2].to_i
      return hours+mins+secs
    end
end
