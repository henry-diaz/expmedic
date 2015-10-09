class Panel::ConsultationsController < Panel::TabledController

  def model
    Consultation
  end

  def table_headers
    %w(admin_id patient)
  end

  def init_form
    @consultations = Consultation.accessible_by(current_ability).order(created_at: :desc)
  end

  private

    def item_params
      params.require(:consultation).permit(:clinic_id, :patient_id)
    end
end
