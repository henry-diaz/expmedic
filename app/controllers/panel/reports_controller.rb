class Panel::ReportsController < Panel::TabledController

  def model
    Report
  end

  def table_headers
    %w(name)
  end

  def init_form
  end

  private

    def item_params
      params.require(:setting).permit()
    end
end
