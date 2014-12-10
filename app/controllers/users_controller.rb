class UsersController < ApplicationController
  before_action :authenticate_owner!
  before_filter :set_user

  def show
  end

  def edit
    @user.build_profile if @user.profile.nil?
  end

  def update
    if @user.update(user_params)
      redirect_to user_profile_path(@user)
    else
      render 'edit'
    end
  end

  def edit_password
  end

  def update_password
    if @user.update(user_change_password_params)
      sign_in :user, @user, bypass: true
      redirect_to user_profile_path(@user)
    else
      render 'edit_password'
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(profile_attributes: [:id, :name, :cid, :birthday, :sex, :tel, :address, :tagline, :introduction, :avatar])
    end

    def user_change_password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def authenticate_owner!
      redirect_to root_path unless user_signed_in? && current_user.to_param == params[:id]
    end
end
