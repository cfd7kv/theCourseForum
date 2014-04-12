class Subdepartment < ActiveRecord::Base
  has_and_belongs_to_many :department
  has_many :courses

  validates_presence_of :name, :mnemonic

  #Returns: Array[professor]
  #returns a list of all of the professors in a subdepartment with no particular sorting.
  def professors_list
    profs = []
    self.courses.each do |course|
      profs += course.professors_list
    end

    return profs
  end
end
