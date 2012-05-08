class ProfilesController < ApplicationController
  before_filter :redirect_to_root, :unless => :signed_in?, :except => :show

  def edit
  end

  def show
    @user  = User.find_by_slug!(params[:id])
  end

  def update
    if current_user.update_attributes(params[:user])
      flash[:success] = "Your profile was updated."
    else      
      flash[:notice] = current_user.errors.full_messages.to_sentence
    end
    redirect_to edit_profile_path
  end
end
