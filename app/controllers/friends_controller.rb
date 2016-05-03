get '/users/:id/friends' do
  @user = User.find(params[:id])
  @friends = @user.all_friends
  erb :'friend/index'
end

get '/friends/:friend_id/new' do
  unless Friendship.find_by(user_id: params[:friend_id], friend_id: current_user.id) || Friendship.find_by(friend_id: params[:friend_id], user_id: current_user.id)
    Friendship.create(friend_id: params[:friend_id], user_id: current_user.id)
  end
  redirect "/users/#{current_user.id}/friends"
end

get '/unfriend/:friend_id' do
  @friendship = Friendship.find_by(friend_id: params[:friend_id], user_id: current_user.id)
  @friendship ||= Friendship.find_by(friend_id: current_user.id, user_id: params[:friend_id])
  @friendship.destroy if @friendship
  redirect to "/users/#{current_user.id}/friends"
end