class Admin::UsersController < Admin::BaseController

  def index
    add_crumb "users", "/admin/users"
    @people = User.listed.by_position
    @unlisted = User.unlisted
  end
  
  def new
    add_crumb "create user", "/admin/users/new"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:fancy] = "Account registered!"
      redirect_back_or_default admin_users_path
    else
      flash[:error] = "Account registration failed. Oops!"
      render :action => :new
    end
  end

  def show
    add_crumb "#{@current_user.login} profile", "#{admin_user_path(@current_user)}"
    @user = User.from_param(params[:id])
  end

  def edit
    add_crumb "edit profile", "#{edit_admin_user_path(@current_user)}"
    @user = User.from_param(params[:id])
  end

  def update
    @user = User.from_param(params[:id])
    if @user.update_attributes(params[:user])
      flash[:fancy] = "Account successfully updated!"
      redirect_to admin_users_url
    else
      flash[:error] = "Account update failed. Oopsi!"
      render :action => :edit
    end
  end
  
  def update_positions
    params[:positions].each do |user_id, position|
      User.find_by_id(user_id).update_attributes(:position => position)
    end
    redirect_to :back
  end  

  def destroy
    @user = User.from_param(params[:id])
    if @user.destroy
      flash[:fancy] = "User removed successfully."
    else
      flash[:error] = "Problem removing user."
    end
    
    redirect_to :back
  end
end