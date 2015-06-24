**Note** Always use secure connection (HTTPS) when connecting to Fiery API in production.

Setup the bundler with either `bundle install` or `bundle install --without default` then execute the script with `bundle exec ruby sample.rb`

### Login

```ruby
loginJson = {
  :username => '{{the username}}',
  :password => '{{the password}}',
  :accessrights => '{{the api key}}'
}

client = RestClient::Resource.new "https://{{the server name or ip address}}/live/api/v2/", :headers => {}, :verify_ssl => OpenSSL::SSL::VERIFY_NONE

request = loginJson.to_json
response = client['login'].post request, { :content_type => 'application/json' }

client.options[:headers][:cookies] = response.cookies
```


### Logout

```ruby
response = client['logout'].post nil
```


### Get jobs

```ruby
response = client['jobs'].get
```


### Get single job

```ruby
job_id = "{{job id}}" # e.g. 00000000.558895DF.16055
response = client["jobs/#{job_id}"].get
```


### Print a job

```ruby
job_id = "{{job id}}" # e.g. 00000000.558895DF.16055
response = client["jobs/#{job_id}/print"].put nil
```


### Get job preview

```ruby
job_id = "{{job id}}" # e.g. 00000000.558895DF.16055
response = client["jobs/#{job_id}/preview/1"].get
```
