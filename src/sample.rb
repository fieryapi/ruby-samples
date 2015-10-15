require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])


require 'base64'
require 'json'
require 'rest-client'


## *****************************************************************************
## configuration section
## *****************************************************************************

# set the host name as fiery server name or ip address
$hostname = 'the_server_name_or_ip_address'

# set the key to access Fiery API
$api_key = 'the_api_key'

# set the username to login to the fiery server
$username = 'the_username'

# set the password to login to the fiery server
$password = 'the_password'

# set the job id on the fiery server to retrieve job information and preview
$job_id = 'the_job_id'

# set the full file path for job submission
$full_path = 'the_job_content_full_file_path'

## *****************************************************************************
## set the job id on the fiery server to retrieve job information and preview
## *****************************************************************************

# get the first page preview of the job
def get_job_preview_sample(client)
  response = client["jobs/#{$job_id}/preview/1"].get

  p ''
  p 'Get job preview'
  uri = "data:image/jpeg;base64,#{Base64.strict_encode64 response}"
  p uri
end

# get job information from all jobs on the fiery server
def get_jobs_sample(client)
  response = client['jobs'].get

  p ''
  p 'Get jobs'
  p response
end

# get job information of a single job on the fiery server
def get_single_job_sample(client)
  response = client["jobs/#{$job_id}"].get

  p ''
  p 'Get single job'
  p response
end

# login to the fiery server
def login_sample()
  login_json = {
    :username => $username,
    :password => $password,
    :accessrights => $api_key
  }

  client = RestClient::Resource.new "https://#{$hostname}/live/api/v2/", :headers => {}, :verify_ssl => OpenSSL::SSL::VERIFY_NONE

  request = login_json.to_json
  response = client['login'].post request, { :content_type => 'application/json' }

  client.options[:headers][:cookies] = response.cookies

  p ''
  p 'Login'
  p response
  client
end

# logout from the fiery server
def logout_sample(client)
  response = client['logout'].post nil

  client.options[:headers][:cookies] = response.cookies

  p ''
  p 'Logout'
  p response
end

# create a new job on the fiery server
def post_job_content_sample(client)
  job_multipart = {
    :file => File.new($full_path),
    'num copies' => 10
  }

  response = client['jobs'].post job_multipart

  p ''
  p 'Submit a new job'
  p response
end

def update_job_attribute_sample(client)
  job_json = {
    :attributes => {
      'num copies' => 1
    }
  }

  response = client["jobs/#{$job_id}"].put job_json

  p ''
  p 'Update a job'
  p response
end

# send a print action to a job on the fiery server
def print_job_sample(client)
  response = client["jobs/#{$job_id}/print"].put nil

  p ''
  p 'Print a job'
  p response
end


# main method executing all sample code
def main
  client = login_sample
  post_job_content_sample client
  get_jobs_sample client
  get_single_job_sample client
  update_job_attribute_sample client
  print_job_sample client
  get_job_preview_sample client
  logout_sample client
end

main
