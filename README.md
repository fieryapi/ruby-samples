## ruby samples

Fiery job management samples. Setup the bundler in `src` directory with either `bundle install` or `bundle install --without default`, modify `sample.rb` in the configuration section to connect to the Fiery then execute the script with `bundle exec ruby sample.rb`


**Note** Always use secure connection (HTTPS) when connecting to Fiery API in production.

### Login

```ruby
loginJson = {
  :username => $username,
  :password => $password,
  :accessrights => $api_key
}

client = RestClient::Resource.new "https://#{$hostname}/live/api/v2/", :headers => {}, :verify_ssl => OpenSSL::SSL::VERIFY_NONE

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
$job_id = 'the_job_id' # e.g. 00000000.558895DF.16055
response = client["jobs/#{$job_id}"].get
```


### Print a job

```ruby
$job_id = 'the_job_id' # e.g. 00000000.558895DF.16055
response = client["jobs/#{$job_id}/print"].put nil
```


### Get job preview

```ruby
$job_id = 'the_job_id' # e.g. 00000000.558895DF.16055
response = client["jobs/#{$job_id}/preview/1"].get
```
