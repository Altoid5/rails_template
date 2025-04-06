class EmailCodesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :verify]

  def new
  end

  def create
    email = params[:email].to_s.downcase

    if email.present?
      user = User.find_or_create_by(email: email)
      code = SecureRandom.hex(3).upcase

      user.update(
        verification_code: code,
        code_sent_at: Time.current
      )

      UserMailer.verification_code_email(user).deliver_now
      redirect_to verify_code_path(email: email)
    else
      flash[:alert] = "Please enter a valid email."
      render :new
    end
  end

  def verify
    @user = User.find_by(email: params[:email])

    if request.post?
      if @user&.verify_code_matches?(params[:code])
        sign_in(@user)
        flash[:notice] = "Login successful!"
        redirect_to authenticated_root_path
      else
        flash.now[:alert] = "Invalid or expired verification code."
        render :verify, status: :unprocessable_entity
      end
    end
  end

  def destroy
    sign_out current_user
    redirect_to unauthenticated_root_path, notice: "Signed out successfully."
  end
end