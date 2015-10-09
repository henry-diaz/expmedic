class Panel::AdminsController <  Panel::TabledController
  def model
    Admin
  end

  def table_headers
    %w(firstname lastname email role_string)
  end

  def init_form
    @admins = Admin.accessible_by(current_ability).order(:firstname)
  end

  private

    def item_params
      params.require(:admin).permit(:firstname, :lastname, :username, :role, :email, :password, :password_confirmation, :clinic_id)
    end
end
