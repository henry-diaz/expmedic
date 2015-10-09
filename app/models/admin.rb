class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :clinic

  delegate :patients_count, :acronym , to: :clinic, allow_nil: true, prefix: true

  attr_accessor :login

  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    }
  validates :role, :firstname, presence: true

  ROLE = {
    'manager' => 'Administrador',
    'receptionist' => 'Recepcionista'
  }

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_hash).first
    end
  end

  def role_string
    ROLE[self[:role]]
  end

  def as_json(options={})
    super(:methods => [:role_string])
  end

end
