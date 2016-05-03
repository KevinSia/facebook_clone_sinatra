get '/users/:id/friends' do
  @friends = User.find(params[:id]).all_friends
  erb :'friend/index'
end