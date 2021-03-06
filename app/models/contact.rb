class Contact < ActiveRecord::Base
  attr_accessible :email, :first_name, :language, :last_name, :phone_number, :relationship_to_student, :contact_students_attributes
  has_many :messages, :through => :contact_messages
  has_many :contact_messages
  has_many :students, :through => :contact_students
  has_many :contact_students
  validates_presence_of :first_name, :last_name, :relationship_to_student, :phone_number
  validates_inclusion_of :language, :in => lambda{ |contact| Contact.valid_languages}
  validates_inclusion_of :relationship_to_student, :in => lambda{|contact| Contact.valid_relations}
  accepts_nested_attributes_for :contact_students, :allow_destroy => true
  validates :phone_number, :format => /1?-?\d{3}-?\d{3}-?\d{4}/

  def full_name
    self.first_name +" " + self.last_name
  end

  def active_for?(student)
    self.contact_students.where(:student_id => student.id).first.active?
  end

  def self.valid_relations
    [
      "Mother",
      "Father",
      "Guardian",
      "Grandmother",
      "Grandfather",
      "Aunt",
      "Uncle"
    ]
  end

  def self.valid_languages
    [
      "English",
      "Spanish",
      "Chinese",
      "Tagalog",
      "Japanese",
      "French",
      "German", 
    ]
  end

end
