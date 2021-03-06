class Message < ActiveRecord::Base
  attr_accessible :content, :header, :time_sent, :teacher_id, :subject
  belongs_to :teacher
  has_many :contacts, :through => :contact_messages
  has_many :contact_messages
  has_and_belongs_to_many :students

  validates :content, :presence => true
  validates :time_sent, :presence => true

  # scope :sent, where("id = ?", (ContactMessage.all.where("delivered = ? AND message_id = ?", true, message.id ))) 

  def students_to
    self.students.pluck(:first_name).join(', ')
  end

  def sent_on
    self.time_sent.getlocal.strftime("%m/%d/%y @ %H:%M")
  end

end
