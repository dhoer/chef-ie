require 'spec_helper'

describe 'ie::zone' do
  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2').converge(described_recipe)
    end

    it 'enables protected mode for internet' do
      create_registry_key('HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3')
        .with(name: '2500', type: :dword, data: 0)
    end
    it 'enables protected mode for local internet' do
      create_registry_key('HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1')
        .with(name: '2500', type: :dword, data: 0)
    end
    it 'enables protected mode for trusted sites' do
      create_registry_key('HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2')
        .with(name: '2500', type: :dword, data: 0)
    end
    it 'enables protected mode for restricted sites' do
      create_registry_key('HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4')
        .with(name: '2500', type: :dword, data: 0)
    end
  end

  context 'not windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new.converge(described_recipe)
    end

    it 'should warn if not Windows platform' do
      expect(chef_run).to write_log('Recipe ie::zone is only available for Windows platforms!')
    end
  end
end
