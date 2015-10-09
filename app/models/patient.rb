class Patient < ActiveRecord::Base
  belongs_to :clinic

  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  validates :firstname, :lastname, :birthdate, :gender, presence: true
  validates :responsible, presence: true, if: :minor?

  GENDER = {
    'm' => 'Hombre',
    'f' => 'Mujer'
  }


  def minor?
    age < 18
  end

  def age
    now = Time.now.utc.to_date
    now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
  end

  def fullname
    [lastname, firstname].join(', ')
  end
end
