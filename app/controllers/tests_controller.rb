class TestsController < ApplicationController
  before_action :init_start_time, only: [:show]
  http_basic_authenticate_with name: "James", password: "secret", only: :index
  
  def index
    @tests = Test.all
    @tests.each do |test|
      test.total_questions_answered = test.answers.count
    end
  end
  
  def show
    @test = Test.find(params[:id])
    if @test.answers.count == 20
      time = Time.new
      @test.finished_time = time.strftime("%H:%M:%S")
      @test.time_taken = calculate_time_taken(@test)
      @test.save
      
      render "completed"
    end
  end
  
  def new
    session[:start_time] = nil
    @test = Test.new
  end
  
  def create
    @test = Test.new
    @test.save
    redirect_to @test
  end
  
  def completed
    @test = Test.find(params[:id])
    @test.time_taken = "02:00"
    @test.save
    
    render "completed"
  end
  
  private
    def init_start_time
      @test = Test.find(params[:id])
      if session[:start_time].nil?
        puts 'initializing start time'
        time = Time.new
        session[:start_time] = time.strftime("%H:%M:%S")
        @test.start_time = session[:start_time]
        @test.save
      end
    end
  
    def calculate_time_taken(test)
      time_taken = convert_to_seconds(test.finished_time) - convert_to_seconds(test.start_time)
      if time_taken > 60
        mins = "01"
        secs = time_taken - 60
        if secs < 10 #secs will not be 0 because time_taken can't be 60 here
          secs_string = "0" << secs.to_s
        else
          secs_string = secs.to_s
        end
        return mins << ':' << secs_string
      elsif time_taken < 60
        if time_taken < 10
          time_taken_string = "0" + time_taken.to_s
        else
          time_taken_string = time_taken.to_s
        end
        return "00:" << time_taken_string
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