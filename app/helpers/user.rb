helpers do
  def check_authorization(id)
    redirect to '/home' unless id.to_i == current_user.id
  end
end