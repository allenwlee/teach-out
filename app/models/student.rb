class Student < ActiveRecord::Base
  attr_accessible :first_name, :last_name
  belongs_to :teacher
end