# config/initializers/carrierwave.rb
if Rails.env == 'production'
   CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'                        # required
    config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     'AKIAIZ2JSDFDTROSJG5A',       # required
      aws_secret_access_key: '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', # required
      region:                'eu-west-1',                  # optional, defaults to 'us-east-1'
      host:                  'agora.rockstars.mx',             # optional, defaults to nil
      endpoint:              'https://agora-shapes-and-forms.s3-website-us-west-1.amazonaws.com' # optional, defaults to nil
    }
    config.fog_directory  = 'agora-shapes-and-forms'                     # required
    config.fog_public     = false                                        # optional, defaults to true
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
   end
end