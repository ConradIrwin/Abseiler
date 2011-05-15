require "abseiler"
class GithubRaplet < Abseiler::Raplet
  include Octopi

  short_name      :github
  description     "Shows some basic statistics from and a link to your contacts' Github Profiles."
  small_icon_url  "https://github.com/favicon.ico"

  data_provider_name "Github Inc."
  data_provider_url   "http://github.com"

  before_filter :find_user

  private

  def find_user
    not_found! and return false if params[:email].blank?

    if params[:email] =~ /reply\.github\.com\z/
      not_found! and return false if params[:name].blank?

      @user = User.find(params[:name])
    else
      @user = User.find_by_email(params[:email])
    end

    not_found! and return false if @user.blank?
  rescue ArgumentError
    not_found! and return false
  end

end
