# encoding: utf-8

class PasswordResetsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:email])
  	user.send_password_reset if user
  	redirect_to root_url, :notice => "Email envidado con instrucciones para restablecer la contraseña"
	end

	def edit
  	@user = User.find_by!(password_reset_token:(params[:id]))
	end

	def update
  @user = User.find_by!(password_reset_token:(params[:id]))
  if @user.password_reset_sent_at < 2.hours.ago
    redirect_to new_password_reset_path, :alert => "El tiempo para restablecer la contraseña ha expirado."
  elsif @user.update_attributes(password_reset_params)
    redirect_to root_url, :notice => "La contraseña se ha restablecido"
  else
    render :edit
  end
end

	private
  	def password_reset_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

end
