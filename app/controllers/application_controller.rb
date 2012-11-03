require 'rubygems'
require 'google/api_client'
class ApplicationController < ActionController::Base
  protect_from_forgery

  CLIENT_ID = '399664129279.apps.googleusercontent.com'
  CLIENT_SECRET = 'lqk6zSm1YZyjETgQX5TMesSN'
  OAUTH_SCOPE = 'https://www.googleapis.com/auth/drive'

  def setup_client
    @client = Google::APIClient.new
    @client.authorization.client_id = CLIENT_ID
    @client.authorization.client_secret = CLIENT_SECRET
    @client.authorization.scope = OAUTH_SCOPE
    redirect = url_for :controller => self.controller_name, :action => self.action_name 

    # Request authorization
    @client.authorization.redirect_uri = redirect
    @drive = @client.discovered_api('drive', 'v2')
    if params[:code].nil? && session[:code].nil?
      @uri = @client.authorization.authorization_uri
      puts "0"
    elsif !session[:code].nil?
      puts "1"
      @client.authorization.code = session[:code].chomp
      @client.authorization.fetch_access_token!
    elsif !params[:code].nil?
      puts "2"
      puts params[:code]
      @client.authorization.code = params[:code].chomp
      @client.authorization.fetch_access_token!
    end
    puts "PUPPIES"
    puts @client.authorization.code
  end

  ##
# Create a new file
#
# @param [Google::APIClient] client
#   Authorized client instance
# @param [String] title
#   Title of file to insert, including the extension.
# @param [String] description
#   Description of file to insert
# @param [String] parent_id
#   Parent folder's ID.
# @param [String] mime_type
#   MIME type of file to insert
# @param [String] file_name
#   Name of file to upload
# @return [Google::APIClient::Schema::Drive::V2::File]
#   File if created, nil otherwise
  def insert_file(client, title, description, parent_id, mime_type, file_name)
    drive = client.discovered_api('drive', 'v2')
    file = drive.files.insert.request_schema.new({
      'title' => title,
      'description' => description,
      'mimeType' => mime_type
    })
    # Set the parent folder.
    if parent_id
      file.parents = [{'id' => parent_id}]
    end
    media = Google::APIClient::UploadIO.new(file_name, mime_type)
    result = client.execute(
      :api_method => drive.files.insert,
      :body_object => file,
      :media => media,
      :parameters => {
        'uploadType' => 'multipart',
        'alt' => 'json'})
    if result.status == 200
      return result.data
    else
      puts "An error occurred: #{result.data['error']['message']}"
      return nil
    end
  end
end
