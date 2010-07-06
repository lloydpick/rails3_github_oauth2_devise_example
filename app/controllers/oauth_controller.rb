class OauthController < ApplicationController

  def new
    redirect_to client.web_server.authorize_url(
      :redirect_uri => oauth_callback_url, :scope => 'offline_access,user'
    )
  end

  def callback
    access_token = client.web_server.get_access_token(
      params[:code], :redirect_uri => oauth_callback_url
    )

    user_json = access_token.get('/api/v2/yaml/repos/watched/lloydpick')
    # in reality you would at this point store the access_token.token value as well as
    # any user info you wanted
    render :text => user_json
  end

  protected

  def client
    @client ||= OAuth2::Client.new(
      '25f55be888db71505992',
      '58c52cd9d2ee05e38552795032cceffdd48a132a',
      :site => 'https://github.com',
      :authorize_path => '/login/oauth/authorize',
      :access_token_path => '/login/oauth/access_token'
    )
  end


end
