require 'json'

module Variables 

  class VariableHolder 
    def initialize(nativity_repo_path, jira_email, jira_api_token)
      @nativity_path = nativity_repo_path
      @jira_email = jira_email
      @jira_api_token = jira_api_token
    end

    def nativity_path() 
      if (@nativity_path == nil || @nativity_path.length == 0)
        raise "Nativity repo path not set, please check variables.json"
      end

      return @nativity_path;
    end

    def jira_email()
      if (@jira_email == nil || @jira_email.length == 0)
        raise "Jira email not set, please check variables.json"
      end

      return @jira_email;
    end

    def jira_api_token() 
      if (@jira_api_token == nil || @jira_api_token.length == 0)
        raise "Jira api token not set, please check variables.json"
      end

      return @jira_api_token;
    end
  end

  @@variableHolder = nil

  def self.load_variables() 
    variablesJsonPath = File.join(__dir__, "../variables.json")
    

    if @@variableHolder == nil
      File.open(variablesJsonPath, "r") do |file|
        puts "Loading variables from file"
        json = JSON.parse(file.read);
        @@variableHolder = VariableHolder.new(json["nativityRepoPath"], json["jiraEmail"], json["jiraApiToken"])
      end
    end

    return @@variableHolder;
  end

end