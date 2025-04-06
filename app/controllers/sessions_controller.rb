def destroy
  reset_session
  redirect_to root_path, notice: "Logged out!"
end