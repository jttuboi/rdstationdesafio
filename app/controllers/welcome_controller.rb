class WelcomeController < ApplicationController
  def conectar
    @dados = YAML.load(File.read(Rails.root.join('config/salesforce.yml')))
    
  end
  
end
