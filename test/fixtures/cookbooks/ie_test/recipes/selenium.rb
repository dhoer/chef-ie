# https://code.google.com/p/selenium/wiki/InternetExplorerDriver#Required_Configuration
major_version = ie_version.split('.')[0].to_i

# For IE 11 only, you will need to set a registry entry on the target computer so that the driver can maintain a
# connection to the instance of Internet Explorer it creates.
include_recipe 'ie::bfcache' if major_version >= 11

include_recipe 'ie::esc' # remove annoying popups

# On IE 7 or higher, you must set the Protected Mode settings for each zone to be the same value. The value can be on
# or off, as long as it is the same or every zone.
if major_version >= 7
  node.set['ie']['zone']['internet'] = {
    '2500' => 0, # enable protected zone
    '1400' => 0 # enable javascript
  }
  include_recipe 'ie::zone'
end
