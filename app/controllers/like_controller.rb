get "/statuses/:id/like" do
  @status = current_user.likes.find_or_create_by(status_id: params[:id])
  redirect back
end

get "/statuses/:id/unlike" do
  @status = Like.find_by(status_id: params[:id])
  @status.destroy if @status
  redirect back
end
