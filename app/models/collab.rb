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
    copied_file = drive.files.copy.request_schema.new({
        'title' => self.title 
      })
    result = client.execute(
      :api_method => drive.files.copy,
      :body_object => copied_file,
      :parameters => { 'fileId' => "1ElOgWlwmYa2tYGu7mdYn0U-6CHBEYwrQFm6eU8kzJkw",
                       'convert' => 'true'})
    self.file = result.data.id
    new_permission = drive.permissions.insert.request_schema.new({
    'value' => "me",
    'type' => "anyone",
    'role' => "writer" 
    })
    result = client.execute(
      :api_method => drive.permissions.insert,
      :body_object => new_permission,
      :parameters => { 'fileId' => self.file })
  end
end
