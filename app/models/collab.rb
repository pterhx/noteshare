class Collab < ActiveRecord::Base
  attr_accessible :course_id, :file, :title
  # Callbacks
  before_save :get_file

  # Relationships
  belongs_to :course

  private
  CLIENT_ID = '399664129279.apps.googleusercontent.com'
  CLIENT_SECRET = 'lqk6zSm1YZyjETgQX5TMesSN'
  OAUTH_SCOPE = 'https://www.googleapis.com/auth/drive'
  def get_file
    client = Google::APIClient.new
    client.authorization.client_id = CLIENT_ID
    client.authorization.client_secret = CLIENT_SECRET
    client.authorization.scope = OAUTH_SCOPE
    redirect = URI("http://google.com") 
    client.authorization.redirect_uri = redirect
    client.authorization.refresh_token = '1/Y0dnkJsq4GqyYHolx8R8D-jxfl2RF993AWTp4btv_Xs'
    client.authorization.fetch_access_token!
    drive = client.discovered_api('drive', 'v2')

    file = drive.files.insert.request_schema.new({
      'title' => self.title, 
      'description' => "collaborative note",
      'mimeType' => "application/msword"
    })
    File.new("ROFL.doc", "r")
    media = Google::APIClient::UploadIO.new("ROFL.doc", "application/msword")
    result = client.execute(
      :api_method => drive.files.insert,
      :body_object => file,
      :media => media,
      :parameters => {
        'uploadType' => 'multipart',
        'alt' => 'json'})
    if result.status == 200
      self.file = result.data.id
    else
      puts "An error occurred: #{result.data['error']['message']}"
      return nil
    end
  end

end
