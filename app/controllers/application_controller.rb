class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      root_path          #pathは設定したい遷移先へのpathを指定してください
    when Customer
      root_path              #ここもpathはご自由に変更してください
    end

  end

  def after_sign_out_path_for(resource)

    case resource
    when :admin

       new_admin_session_path
   #pathは設定したい遷移先へのpathを指定してください
    when :customer
       root_path              #ここもpathはご自由に変更してください
    end
  end




  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name,:last_name_kana,:first_name_kana,:address,:telephone_number,:postal_code])
      devise_parameter_sanitizer.permit(:account_update, keys: [:last_name, :first_name,:last_name_kana,:first_name_kana,:address,:telephone_number,:postal_code, :passwo])
    end

end
