require 'spec_helper'

describe 'ie::esc' do
  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        node.set['kernel']['machine'] = 'x86_64'
      end.converge(described_recipe)
    end

    it 'disable user enhanced_security_configuration' do
      create_registry_key(
        'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}'
      )
        .with(name: 'IsInstalled', type: :dword, data: 0)
    end

    it 'disable administrators enhanced_security_configuration' do
      create_registry_key(
        'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}'
      )
        .with(name: 'IsInstalled', type: :dword, data: 0)
    end

    it 'turn off ieharden' do
      create_registry_key(
        'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap'
      )
        .with(name: 'IEHarden', type: :dword, data: 0)
    end
  end

  context 'not windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new.converge(described_recipe)
    end

    it 'should warn if not Windows platform' do
      expect(chef_run).to write_log(
        'Recipe ie::esc is only available for Windows platforms!'
      )
    end
  end
end
