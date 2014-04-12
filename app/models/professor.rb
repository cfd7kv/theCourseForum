class Professor < ActiveRecord::Base
  belongs_to :department
  has_many :section_professors
  has_many :sections, :through => :section_professors
  has_many :course_semesters, :through => :sections
  has_many :courses, :through => :course_semesters

  validates_presence_of :first_name, :last_name

  #Returns: Array[courses]
  #returns a list of courses this professor teaches.  Sorted Alphabetically by course name
  def courses_list
    return self.courses.uniq{ |p| p.id }.sort_by{|p| p.subdepartment.mnemonic}
  end

  #Returns: String
  #returns the professor's first name follower by the professors last name separated by a space.
  def full_name
    self.first_name + " " + self.last_name
  end

  #Retruns: String
  #returns the professors last name followed by the professors first name, separated by a comma and space.
  def separated_name
    self.last_name + ", " + self.first_name
  end
end
