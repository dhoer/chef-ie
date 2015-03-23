# https://code.google.com/p/selenium/wiki/InternetExplorerDriver#Required_Configuration
node.set['ie']['enhanced_security_configuration'] = false
include_recipe 'ie::enhanced_security_configuration'

major_version = ie_version.split('.')[0].to_i

# On IE 7 or higher, you must set the Protected Mode settings for each zone to be the same value. The value can be on
# or off, as long as it is the same or every zone.
if major_version >= 7
  node.set['ie']['zone']['internet'] = { '2500' => 0, '1400' => 0 } # enable javascript
  include_recipe 'ie::security_zones'
end

# For IE 11 only, you will need to set a registry entry on the target computer so that the driver can maintain a
# connection to the instance of Internet Explorer it creates.
if major_version >= 11
  node.set['ie']['feature_bfcache'] = true
  include_recipe 'ie::feature_bfcache'
end
