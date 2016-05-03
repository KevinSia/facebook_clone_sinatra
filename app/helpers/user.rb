helpers do
  def check_authorization(id)
    redirect to '/home' unless id.to_i == current_user.id
  end

  def check_friendship(status)
    unless status.user.all_friends.include?(current_user) || status.user == current_user
      redirect to "/make_friend/#{status.user.id}"
    end
  end
end