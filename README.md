# IE Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/ie.svg?style=flat-square)][cookbook]
[![Build Status](http://img.shields.io/travis/dhoer/chef-ie.svg?style=flat-square)][travis]
[![GitHub Issues](http://img.shields.io/github/issues/dhoer/chef-ie.svg?style=flat-square)][github]

[cookbook]: https://supermarket.chef.io/cookbooks/ie
[travis]: https://travis-ci.org/dhoer/chef-ie
[github]: https://github.com/dhoer/chef-ie/issues

Configures Internet Explorer to aid tools like [Selenium](http://www.seleniumhq.org/).

The following recipes are available for configuring Internet Explorer:

- **[enhanced_security_configuration](https://github.com/dhoer/chef-ie#enhanced_security_configuration)** -
Enable/Disable IE Enhanced Security Configuration
- **[feature_bfcache](https://github.com/dhoer/chef-ie#feature_bfcache)** - Enable/Disable IE Feature Back-Forward
Cache
- **[security_zones](https://github.com/dhoer/chef-ie#security_zones)** - Configure IE Security Zones;
Local Home, Internet, Local Internet, Trusted Sites, and Restricted Sites

A `ie_version` method is also available to retrieve the exact version of Internet Explorer installed.

Tested against IE 11 on Windows Server 2012 R2.

## Requirements

- Chef 11.6.0 or higher (includes a built-in registry_key resource)

## Platforms

- Windows

## Usage

See [ie_test](https://github.com/dhoer/chef-ie/tree/master/test/fixtures/cookbooks/ie_test) cookbook for examples.
Include `ie` as a dependency to make `ie_version` method available. Note that there is no default recipe.

A library method `ie_version` is provided to retrieve the IE version installed:

```ruby
v = ie_version
```

**Tip:** use `allow_any_instance_of` to stub ie_version method when testing with rspec:

```ruby
allow_any_instance_of(Chef::Recipe).to receive(:ie_version).and_return('11.0.0.0')
```

## ie::enhanced_security_configuration

Enable/Disable Internet Explorer Enhanced Security Configuration.

Note this sets `HKEY_CURRENT_USER` keys, so it configures only the user that the chef-client runs as.

### Attributes

- `node['ie']['enhanced_security_configuration']` - Defaults to `true`

### Example

Disable enhanced security configuration:

```ruby
node.set['ie']['enhanced_security_configuration'] = false
include_recipe 'ie::enhanced_security_configuration'
```

## ie::feature_bfcache

Enable/Disable IE Feature Back-Forward Cache.  Allows drivers to maintain a connection to IE.

### Attributes

- `node['ie']['feature_bfcache']` - Defaults to `false`

### Example

Enable feature_bfcache:

```ruby
node.set['ie']['feature_bfcache'] = true
include_recipe 'ie::feature_bfcache'
```

## ie::security_zones

Configure IE Security Zones (REG_DWORD types only); Local Home, Internet, Local Internet, Trusted Sites, and
Restricted Sites. See Zones section in http://support.microsoft.com/kb/182569 for a complete listing of security zone
settings.

A setting of zero sets a specific action as permitted, a setting of one causes a prompt to appear, and a setting
of three prohibits the specific action.

Note this sets `HKEY_CURRENT_USER` keys, so it configures only the user that the chef-client runs as.

### Attributes

- `node['ie']['zone']['local_home']` - Configure local home zone.  Defaults to `{}`.
- `node['ie']['zone']['internet']` - Configure internet zone.  Defaults to `{ '2500' => 0 }` (Enable Protected Mode).
- `node['ie']['zone']['local_internet']` - Configure local internet zone. Defaults `{ '2500' => 0 }`
(Enable Protected Mode).
- `node['ie']['zone']['trusted_sites']` - Configure trusted sites zone. Defaults to `{ '2500' => 0 }`
(Enable Protected Mode).
- `node['ie']['zone']['restricted_sites']` - Configure restricted sites zone. Defaults to `{ '2500' => 0 }`
(Enable Protected Mode).

### Example

Enable both protected mode and javascript for internet zone:

```ruby
node.set['ie']['zone']['internet'] = { '2500' => 0, '1400' => 0 }
include_recipe 'ie::security_zones'
```


## Getting Help

- Ask specific questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/chef-ie).
- Report bugs and discuss potential features in [Github issues](https://github.com/dhoer/chef-ie/issues).

## Contributing

Please refer to [CONTRIBUTING](https://github.com/dhoer/chef-ie/blob/master/CONTRIBUTING.md).

## License

MIT - see the accompanying [LICENSE](https://github.com/dhoer/chef-ie/blob/master/LICENSE.md) file for details.
