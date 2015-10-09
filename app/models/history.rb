class History < ActiveRecord::Base
  belongs_to :clinic
  belongs_to :patient

  validates :clinic_id, :patient_id, presence: true

  def created_date
    created_at.strftime('%d/%m/%Y')
  end

  def patient_fullname
    patient.try(:fullname)
  end

  def weight_str
    weight ? [weight, 'Kg'].join(' ') : ''
  end

  def size_str
    size ? [size, 'cm'].join(' ') : ''
  end

  def as_json(options={})
    super(:methods => [:patient_fullname, :created_date, :weight_str, :size_str])
  end
end
