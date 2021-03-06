class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    if user.has_role? :super_admin
      can :manage, :all
    elsif user.has_role? :admin
      can :manage, Customer
      can :manage, CustomerPayment
      can :manage, RateChart
      can :manage, DailyCollection
    elsif user.has_role? :editor
      can [:create, :read, :update], Customer
      can [:create, :read, :update, :payment_register, :daily_report], DailyCollection
      can :read, :dashboard
    else
      can :read, :dashboard
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
