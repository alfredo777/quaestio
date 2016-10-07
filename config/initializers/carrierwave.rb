# config/initializers/carrierwave.rb
 CarrierWave.configure do |config|
  if Rails.env == 'production'
    config.fog_credentials = {
      # Configuration for Amazon S3 should be made available through an Environment variable.
      # For local installations, export the env variable through the shell OR
      # if using Passenger, set an Apache environment variable.
      #
      # In Heroku, follow http://devcenter.heroku.com/articles/config-vars
      #
      # $ heroku config:add S3_KEY=your_s3_access_key S3_SECRET=your_s3_secret S3_REGION=eu-west-1 S3_ASSET_URL=http://assets.example.com/ S3_BUCKET_NAME=s3_bucket/folder
   
      # Configuration for Amazon S3
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => 'AKIAI5H33DUN5VUGC4LQ',       # required
      :aws_secret_access_key  => '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',    # required
      #:region                 => 'eu-west-1',                  # optional, defaults to 'us-east-1'
      #:host                   => 's3.example.com',             # optional, defaults to nil
      #:endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
    }
   
    # For testing, upload files to local `tmp` folder.
    if Rails.env.development? || Rails.env.cucumber?
      config.storage = :file
      config.enable_processing = false
      config.root = "#{Rails.root}/tmp"
    else
      config.storage = :fog
    end
   
    config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku
   
    config.fog_directory  = 'agora-shapes-and-forms'
    config.fog_public     = false 
    #config.s3_access_policy = :public_read                          # Generate http:// urls. Defaults to :authenticated_read (https://)
    #config.fog_host         = "#{ENV['S3_ASSET_URL']}/#{ENV['S3_BUCKET_NAME']}"
  end
end