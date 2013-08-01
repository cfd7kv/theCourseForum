class Student < ActiveRecord::Base
  has_many :majors, :through => :student_majors
  has_many :reviews
  validates :first_name, presence: true
  validates :grad_year, presence: true
  #belongs_to :user
end
