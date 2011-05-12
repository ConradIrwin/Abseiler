class GithubController < ApplicationController
  include Octopi

  respond_to :json

  before_filter :metadata
  before_filter :get_user_info

  def user_info
    respond_with({
      sections: [
        {
          expanded_html: render_to_string(:expanded), # render a partial
          collapsed_html: render_to_string(:collapsed), # render a partial
        },
      ],
      css: <<-CSS,
        .collapsed img {
          height:16px;
          width:16px;
          padding:4px;
          margin-left:2px;
        }
        .github img {
          height:22px;
          width:22px;
          padding:0;
          border:1px solid transparent;
          -webkit-border-radius:3px;
          -moz-border-radius:3px;
          border-radius:3px;
          margin-left:2px;
        }
        .github:hover img{
          border-color: transparent;
        }
        .collapsed {
          font-weight: bold;
          line-height: 24px;
        }
        a.github {
          display: block;
          font-size: 1.5em;
          font-weight: bold;
          line-height: 30px;
          margin-top: 0;
          margin-bottom: 0;
          color: #A0A0A0;
        }
        a.github:hover {
          color: #404040;
        }
        img {
          vertical-align: middle;
        }
        .num {
          text-align: center;
          font-size: 32px;
          display: block;
          font-weight: bold;
        }
        .caption {
          display: block;
          text-align: center;
          margin-top: -8px;
          font-size: 9px;
        }
        .stats {
          width: 94px;
          display: block;
          float: left;
          margin: 0 5px 5px;
        }
      CSS
      js: <<-JS,
      JS
      status:200
    })
  end

  private

  def metadata
    metadata_hash = {
      name: "Github",
      description: "Shows some basic statistics from and a link to your contacts' Github Profile.",
      welcome_text: "",
      icon_url: "",
      small_icon_url: "https://github.com/favicon.ico",
      preview_url: "https://abseiler.heroku.com/github/preview.png",
      provider_name: "Lenary",
      provider_url: "http://lenary.co.uk/",
      data_provider_name: "Github Inc.",
      data_provider_url: "http://github.com/"
    }
    respond_with(metadata_hash) and return false if params[:show] == "metadata"
  end

  def get_user_info
    respond_with({status: 404}) and return false if params[:email].blank?
    if params[:email] =~ /reply\.github\.com\z/
      respond_with({status: 404}) and return false if params[:name].blank?
      @user = User.find(params[:name])
    else
      @user = User.find_by_email(params[:email])
    end
    respond_with({status: 404}) and return false if @user.blank?
  rescue ArgumentError
    respond_with({status: 404}) and return false
  end

end
