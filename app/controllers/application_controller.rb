class ApplicationController < ActionController::Base

#認証していな形場合はログイン画面へ（top画面は例外）
	before_action :authenticate_user!, except: [:top, :about]

	before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  #deviseにおけるLog_in/Log_out後の画面設定
  def after_sign_in_path_for(resource)
    user_path(current_user) # ログイン後に遷移するpathを設定
  end

  def after_sign_out_path_for(resource)
    top_path # ログアウト後に遷移するpathを設定
  end
end
