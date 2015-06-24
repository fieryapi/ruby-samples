require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])


require 'base64'
require 'json'
require 'rest-client'


$api_key = '{{the api key}}'
$hostname = '{{the server name or ip address}}'
$job_id = '{{job id}}'
$password = '{{the password}}'
$username = '{{the username}}'



def get_job_preview_sample(client)
  response = client["jobs/#{$job_id}/preview/1"].get

  p ''
  p 'Get job preview'
  uri = "data:image/jpeg;base64,#{Base64.strict_encode64 response}"
  p uri
end

def get_jobs_sample(client)
  response = client['jobs'].get

  p ''
  p 'Get jobs'
  p response
end

def get_single_job_sample(client)
  response = client["jobs/#{$job_id}"].get

  p ''
  p 'Get single job'
  p response
end

def login_sample()
  loginJson = {
    :username => $username,
    :password => $password,
    :accessrights => $api_key
  }

  client = RestClient::Resource.new "https://#{$hostname}/live/api/v2/", :headers => {}, :verify_ssl => OpenSSL::SSL::VERIFY_NONE

  request = loginJson.to_json
  response = client['login'].post request, { :content_type => 'application/json' }

  client.options[:headers][:cookies] = response.cookies

  p ''
  p 'Login'
  p response
  client
end

def logout_sample(client)
  response = client['logout'].post nil

  client.options[:headers][:cookies] = response.cookies

  p ''
  p 'Logout'
  p response
end

def print_job_sample(client)
  response = client["jobs/#{$job_id}/print"].put nil

  p ''
  p 'Print a job'
  p response
end


def main
  client = login_sample
  get_jobs_sample client
  get_single_job_sample client
  print_job_sample client
  get_job_preview_sample client
  logout_sample client
end

main
