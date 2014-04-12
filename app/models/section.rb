class Section < ActiveRecord::Base
  #Part of the association path that associates a professor with a course
  belongs_to :course_semester
  has_many :section_professors
  has_many :professors, :through => :section_professors
  has_many :grades
end
