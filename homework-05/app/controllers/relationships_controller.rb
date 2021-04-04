class RelationshipsController < ApplicationController
  def create
  	@relationship = Relationship.new(following_id: params[:following_id], follower_id: params[:follower_id])
  	path_redirect(@relationship.save)
  end

  def destroy
  	@relationship = Relationship.find_by(following_id: params[:following_id], follower_id: params[:follower_id])
  	path_redirect(@relationship.delete)
  end

  private

  def path_redirect action_result
      path = Rails.application.routes.recognize_path(request.referer)
    if action_result
      if path[:controller] == "users" && path[:action] == "index"
        redirect_to users_path
      elsif path[:controller] == "users" && path[:action] == "follows"
        redirect_to follows_user_path(@relationship.follower_id)
      elsif path[:controller] == "users" && path[:action] == "followers"
        redirect_to followers_user_path(@relationship.follower_id)
      elsif path[:controller] == "users" && path[:action] == "show"
        redirect_to user_path(@relationship.following_id)
      end
    else
      render "#{path[:controller]}/#{path[:action]}"
    end
    end
end
