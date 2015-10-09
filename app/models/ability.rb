class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.is_a? Admin
      case user.role
        when 'admin'
          can :manage, :all
          cannot [:delete, :destroy], Admin, id: user.id
        when 'manager'
          can [:read, :update], Clinic, :id => user.clinic_id
          can :create, Admin
          can [:read, :update, :destroy, :delete], Admin, clinic_id: user.clinic_id
          cannot [:delete, :destroy], Admin, id: user.id
          can :create, Patient
          can [:read, :parent, :edit, :update, :destroy, :delete], Patient, clinic_id: user.clinic_id
      end
    end
  end
end
