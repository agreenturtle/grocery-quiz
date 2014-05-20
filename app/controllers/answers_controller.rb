class AnswersController < ApplicationController
  def index
    @answer = Answer.select { |a| a.test_id.to_i == params[:test_id].to_i }
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
      redirect_to @test
    end
  end
  
end
