class SectionProfessor < ActiveRecord::Base
  #Associates a professor with a section
  belongs_to :section
  belongs_to :professor
end
