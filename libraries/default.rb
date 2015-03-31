# http://support.microsoft.com/en-us/kb/969393
def ie_version
  return unless platform_family?('windows')
  values = registry_get_values('HKLM\SOFTWARE\Microsoft\Internet Explorer')
  values.each do |value|
    return value[:data] if value[:name] == 'svcVersion' # ie >= 10
  end
  values.each do |value|
    return value[:data] if value[:name] == 'Version' # ie < 10
  end
  ''
end
