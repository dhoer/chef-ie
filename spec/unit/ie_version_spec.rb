require 'spec_helper'

describe 'ie_test::ie_version' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do
      allow_any_instance_of(Chef::Recipe).to receive(:ie_version).and_return('11.0.0.0')
    end.converge(described_recipe)
  end

  it 'should return ie version' do
    expect(chef_run).to write_log('11.0.0.0')
  end
end
