class Clinic < ActiveRecord::Base

  has_many :admins, dependent: :destroy
  has_many :patients, dependent: :destroy

  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  validates :name, :acronym, :accounts, :email, presence: true
  validates :name, :phone, :email, length: {maximum: 240}
  validates :acronym, uniqueness: true, format: { without: /\s/ }
  validates :accounts, numericality: { only_integer: true, greater_than: 0 }

  after_create :add_manager

  def add_manager
    generated_password = Devise.friendly_token.first(8)
    admins.create(firstname: 'Administrador', password: generated_password, username: "admin-#{acronym}", role: 'manager', email: "admin@#{acronym}.com")
    UserMailer.welcome_email(self, generated_password).deliver_later
  end

  def total_accounts
    admins.where.not(role: 'manager').count
  end

  def patients_count
    patients.count
  end
end
