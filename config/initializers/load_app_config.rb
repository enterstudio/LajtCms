require 'ostruct'

config_file = File.join(Rails.root, 'config', 'app_config.yml')
config = YAML.load_file(config_file)
env_config, common_config = config[Rails.env] || {}, config['common'] || {}
all_config = common_config.update(env_config)
::AppConfig = OpenStruct.new(all_config)
