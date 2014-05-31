class AnswersController < ApplicationController
  before_action :init_session_variables, only: [:new]
  http_basic_authenticate_with name: "James", password: "secret", only: :index
  
  def index
    @test = Test.find(params[:test_id])
    @answers = Answer.select { |a| a.test_id.to_i == params[:test_id].to_i }
    @questions = Question.new
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
    @answer.is_correct = is_correct_answer(@answer, @test)
    @answer.save

    redirect_to @test
  end
  
  private  
    def is_correct_answer(answer, test)
      if Question.find_by option_one: answer.applicant_answer
        test.score += 1
        test.save
        return 1
      else
        return 0
      end
    end
    
    def init_session_variables
      if session[:question_order].nil?
        session[:question_order] = (1..20).to_a.shuffle
      end
    end
end
