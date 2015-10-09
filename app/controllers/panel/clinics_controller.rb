class Panel::ClinicsController < Panel::TabledController

  def model
    Clinic
  end

  def table_headers
    %w(name acronym address contact phone email)
  end

  def init_form
    @clinics = Clinic.accessible_by(current_ability).order(:name)
  end

  private

    def item_params
      params.require(:clinic).permit(:name, :address, :contact, :phone, :email, :logo, :accounts, :acronym)
    end
end
