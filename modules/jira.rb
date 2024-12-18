require 'net/http'
require_relative 'variables'
require 'json'

module Jira

  @@base_api_url = "https://moneyinfojira.atlassian.net/rest/api/3"

  def self.request_brand_data(monId)
    uri = URI("#{@@base_api_url}/issue/#{monId}?fields=description,attachment")
    variables = Variables.load_variables
    req = Net::HTTP::Get.new(uri)
    req.basic_auth variables.jira_email, variables.jira_api_token

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) {|http|
      http.request(req)
    }

    if res.is_a?(Net::HTTPSuccess) && res.code == '200'
      return JSON.parse res.body
    else
      raise "Could not load issue data"
    end
  end


  def self.get_brand_data(monId)
    body = request_brand_data monId
    if body["fields"]["description"] == nil then raise "Issue data has no description" end
    if body["fields"]["attachment"] == nil then raise "Issue data has no attachments" end
    
    firstTable = body["fields"]["description"]["content"].find {|x| x["type"] == "table"}
    firstZip = body["fields"]["attachment"].find {|x| x["mimeType"] == "application/zip"}
  end

end