class Panel::DashboardController < AdminController

  def index
    @patients_count = Patient.accessible_by(current_ability).count
=begin
    @banned_users_count = BannedUser.accessible_by(current_ability).count
    @uncompleted_users_count = UncompletedUser.accessible_by(current_ability).count
    @users_count = User.accessible_by(current_ability).where(completed: true, banned: false).count
    @used_tokens = Token.used.count
    @winners_count = Winner.accessible_by(current_ability).count
=end
  end
end
