require 'net/http'

class SessionsController < ApplicationController

  def callback
    @auth = request.env['omniauth.auth']
    
    version = getVersion(URI("#{@auth['credentials']['instance_url']}/services/data/"))

    user = User.find_by_provider_and_uid(@auth['provider'],['uid']) || User.create_with_omniauth(@auth)
    session[:user_id] = user.id


     # uri_query = @auth['info']['urls']['sobjects']
     # uri_query["{version}"] = "#{version}"
#   
     # select = '?q=SELECT+name+from+Account'
#      
     # uri = URI("#{uri_query}+#{select}")
    
    
     # Net::HTTP.new(host || URI.parse(self.instance_url).host, 443).tap do |http|
        # http.use_ssl = true
        # http.ca_file = self.ca_file if self.ca_file
        # http.verify_mode = self.verify_mode if self.verify_mode
      # end
    
    
    # Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      # request = Net::HTTP::Get.new uri
#     
      # result = http.request request # Net::HTTPResponse object
      # puts result
    # end
    
    # result = JSON.parse(Net::HTTP.get(uri_query+select))
    # puts result

  # session[:result] = http_get("https://na17.salesforce.com/services/data/v22.0/sobjects/")
  # puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
  # puts session[:result]
  # puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    
    
    redirect_to root_path, :notice => 'Welcome to Salesforce!!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
  
  private
  def getVersion(uri)
    sales = JSON.parse(Net::HTTP.get(uri))
    sales.last['version']
  end

end