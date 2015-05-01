require 'spec_helper'

describe 'ie::firstrun' do
  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        node.set['kernel']['machine'] = 'x86_64'
      end.converge(described_recipe)
    end

    it 'disable first run' do
      create_registry_key(
        'HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Main')
        .with(name: 'DisableFirstRunCustomize', type: :dword, data: 1)
    end

    it 'disable first run current user' do
      create_registry_key(
        'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\ChefIE_FirstRun_DisableFirstRunCustomize')
        .with(name: 'DisableFirstRunCustomize', type: :dword, data: nil)
    end
  end

  context 'not windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new.converge(described_recipe)
    end

    it 'should warn if not Windows platform' do
      expect(chef_run).to write_log(
        'Recipe ie::firstrun is only available for Windows platforms!')
    end
  end
end
