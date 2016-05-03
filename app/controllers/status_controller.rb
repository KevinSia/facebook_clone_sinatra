# show a particular status
get '/statuses/:id' do
end

# create new status
post '/statuses/new' do
  @status = current_user.statuses.build(params[:status])
  unless @status.save
    params[:error_message] = "I can't handle such long status :( . Perhaps keep the hashtag count down?"
  end
  redirect to '/home'
end