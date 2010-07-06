require 'yaml'
require 'pingdom'

class PingrRails


  CONFIG_DIR = File.join(RAILS_ROOT,'config','pingdom.yml')

  class << self
     attr_reader :configuration
   end


   def self.load_config(config_path)
     @config_path = config_path
     @configuration =  YAML.load_file(config_path)
     @p = Pingdom.new(@configuration[:username], @configuration[:password], @configuration[:api_key])
   end

  def self.reload!
    load_config(@config_path)
  end


  private
    def self.method_missing(method, *args, &block)
      throw "Error loading config!" if @p.nil? 
      @p.send(method, *args, &block)
    end

end

PingrRails.load_config(PingrRails::CONFIG_DIR)


if RAILS_ENV == 'development'
  ActionController::Base.class_eval do
    append_before_filter { PingrRails.reload! }
  end
end