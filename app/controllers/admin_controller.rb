class AdminController < ApplicationController

  before_action :authenticate_admin!

  def current_auth_resource
    current_admin
  end

  def current_ability
    @current_ability or @current_ability = Ability.new(current_auth_resource)
  end
end
