class AnswersController < ApplicationController
  before_action :init_session_variables, only: [:new]
  http_basic_authenticate_with name: "James", password: "secret", only: :index
  
  def index
    @answers = Answer.select { |a| a.test_id.to_i == params[:test_id].to_i }
    @questions = Question.new
    @results = score_results(@answers)
    @score = score(@answers)
    @answers = @answers.zip(@results)
    @count = 0;
  end
  
  def show
    @answer = Answer.find(params[:id])
  end
  
  def new
    @test = Test.find(params[:test_id])
    @question = Question.find(session[:question_order][@test.answers.count].to_i)
    @question.question_number = @test.answers.count + 1;
    @test.start_time = session[:start_time]
  end
  
  def create
    @test = Test.find(params[:test_id])
    @answer= @test.answers.create(
      question_name: params[:question],
      applicant_answer: params[:value]
    );
    redirect_to @test
  end
  
  private  
    def score_results(answers)
      @@results = []
      
      answers.each do |a|
        if Question.where(option_one: a.applicant_answer).take
          @@results << 1
        else
          @@results << 0
        end
      end
      return @@results
    end
  
    def score(answers)
      @@score = 0
      answers.each do |a|
        if Question.where(option_one: a.applicant_answer).take
          @@score += 1
        end
      end
      return @@score
    end
    
    def init_session_variables
      if session[:question_order].nil?
        session[:question_order] = (1..20).to_a.shuffle
        time = Time.new
        session[:start_time] = time.strftime("%H:%M:%S")
      end
    end
end
