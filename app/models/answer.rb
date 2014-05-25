class Answer < ActiveRecord::Base
  validates :applicant_answer, presence: true
end
