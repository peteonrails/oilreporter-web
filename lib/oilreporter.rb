module Oilreporter
  def self.config
    Rails.configuration.oilreporter
  end

  class Initializer < Rails::Initializer
    def self.run(what = :process, config = Oilreporter::Configuration.new)
      super(what, config)
    end

    protected

    def process
      super

      unless $gems_rake_task
        setup_amazon_s3
      end
    end

    def load_application_classes
      # Deprecated
      Object.const_set(:APP_CONFIG, Oilreporter.config)
      super
    end

    private
    
    def setup_amazon_s3
      if Oilreporter.config.amazon_s3
        Paperclip::Attachment.default_options.update(
          :storage => :s3,
          :s3_credentials => configuration.amazon_s3_config_file
        )
      end
    end
  end

  class Configuration < Rails::Configuration
    attr_reader :oilreporter
    attr_writer :heroku

    def initialize
      super
      @oilreporter = Rails::OrderedOptions.new
      @heroku = !!ENV['HEROKU_TYPE']

      YAML.load_file(Rails.root + 'config/oilreporter.yml')[RAILS_ENV].each do |key, value|
        @oilreporter[key] = value
      end

      if ENV['URL'] and @oilreporter.app_domain == 'oilreporter.org'
        @oilreporter.app_domain = ENV['URL']
      end

      @oilreporter.amazon_s3 = true if heroku?

      self.time_zone = @oilreporter.time_zone
    end

    def heroku?
      @heroku
    end
    
    def amazon_s3_config_file
      "#{Rails.root}/config/amazon_s3.yml"
    end
  end

end