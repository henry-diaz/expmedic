class DashboardController < ApplicationController
  layout 'dashboard'

  def index
    @promotion = Promotion.where(['start_date <= :date AND stop_date >= :date', date: Date.current]).first
    if session[:social_share].nil?
      session[:social_share] = true
    end
  end
end
