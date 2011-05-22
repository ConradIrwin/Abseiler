# gem "octopi", "~> 0.4.3"
require "abseiler"
class GithubRaplet < Abseiler::Raplet
  short_name      :github
  description     "Shows some basic statistics from and a link to your contacts' Github Profiles."
  small_icon_url  "https://github.com/favicon.ico"
  data_provider   "Github Inc.", "http://github.com"

  include Octopi

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
  rescue ArgumentError, Octopi::NotFound
    not_found! and return false
  end

end
