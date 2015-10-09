class Panel::HistoriesController < Panel::TabledController

  def model
    History
  end

  def table_headers
    %w(created_date patient_fullname weight_str size_str)
  end

  def init_form
    @histories = History.accessible_by(current_ability).order([:patient_id, id: :desc])
  end

  private

    def item_params
      params.require(:history).permit(:clinic_id, :patient_id, :pathological, :nonpathological, :family, :surgical, :allergies, :medicines, :weight, :size)
    end
end
