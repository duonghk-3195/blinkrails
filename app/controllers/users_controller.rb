class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]

  # GET /users or /users.json
  def index
    @page = params[:page] || 1
    @users = User.paginate page: @page, per_page: 2
  end

  # GET /users/1 or /users/1.json
  def show
    @page = params[:page] || 1
    @user = User.find(params[:id])
    @post = @user.posts.paginate page: @page, per_page: 2
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users or /users.json
  def create
    # binding.pry
    @user = User.new(user_params)

    if @user.save
      @user.send_activation_email
      flash[:success] = "Please check your email to activate your account."
      redirect_to login_url
    else
      render :new, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Updated Successfully"
      redirect_to user_url(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # def logged_in_user
    #   unless logged_in?
    #     store_location
    #     flash[:danger] = "You must be logged in to access this page"
    #     redirect_to login_url
    #   end
    # end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # def admin_user
    #   redirect_to(root_url) unless current_user.admin?
    # end

end
