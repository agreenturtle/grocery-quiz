class AnswersController < ApplicationController
  http_basic_authenticate_with name: "James", password: "secret", only: :index
  
  def index
    @answers = Answer.select { |a| a.test_id.to_i == params[:test_id].to_i }
    @questions = Question.new
    @results = score_results(@answers)
    @score = score(@answers)
    @answers = @answers.zip(@results)
  end
  
  def show
    @answer = Answer.find(params[:id])
  end
  
  def create
    @test = Test.find(params[:test_id])
    if !params["applicant_answer"].blank?
      @answer = @test.answers.create(
        question_name: params["answer"]["question_name"],
        applicant_answer: params["applicant_answer"]
      )
      redirect_to @test
    else
      flash[:notice] = "Please select the image that matches the question before submitting"
      redirect_to @test
    end
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
end
