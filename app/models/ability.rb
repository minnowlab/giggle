class Ability
  include CanCan::Ability

  def initialize(user)
    if user.blank?
      # not logged in
      cannot :manage, :all
    end    
    
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
