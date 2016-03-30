class User < ActiveRecord::Base

  has_many :reviews

  has_secure_password

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id # auto log in
      redirect_to movies_path
    else
      render :new
    end
  end

  def full_name
    "#{firstname} #{lastname}"
  end

end
