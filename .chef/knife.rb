# See https://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "purplefeetguy"
client_key               "#{current_dir}/purplefeetguy.pem"
validation_client_name   "linaca-validator"
validation_key           "#{current_dir}/linaca-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/linaca"
cookbook_path            ["#{current_dir}/../cookbooks"]
