# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
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
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

    # guest user (not logged in)
    user ||= User.new 

    # Define :crud
    alias_action :create, :read, :edit, :update, :destroy, to: :crud

    if user.is_admin?
      # manage means they can do everything (not just CRUD)
      can :manage, :all
    end

    # Can :crud post if use is the owner
    can :crud, Post do |post|
      post.user == user
    end

    # Can :crud comment if use is the post or comment's owner
    can :destroy, Comment do |comment|
      comment.user == user || comment.post.user == user
    end

    can :crud, User, id: user.id
  end
end
