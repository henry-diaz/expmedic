class Panel::PatientsController < Panel::TabledController

  def model
    Patient
  end

  def table_headers
    %w(code firstname lastname responsible document_type document_number)
  end

  def init_form
    @patients = Patient.accessible_by(current_ability).order(:firstname)
  end

  def new
    @item = model.new
    @item.code ||= "#{current_admin.try(:clinic_acronym)}-#{current_admin.try(:clinic_patients_count).to_s.rjust(3, '0')}"
    authorize! :create, @item

    init_form
    add_breadcrumb t("activerecord.models.#{model.to_s.underscore}").pluralize(I18n.locale), index_url
    add_breadcrumb t("layouts.panel.breadcrumb.new")
  end

  private

    def item_params
      params.require(:patient).permit(:code, :firstname, :lastname, :birthdate, :gender, :civil_status, :email, :phone, :work_phone, :cellular, :fax, :address, :document_type, :document_number, :occupation, :education_level, :observations, :responsible, :photo, :clinic_id)
    end
end
