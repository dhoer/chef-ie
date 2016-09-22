require 'spec_helper'

describe 'ie::zoom' do
  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2').converge(described_recipe)
    end

    it 'set zoom level to 100 percent' do
      create_registry_key('HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\ChefIE_Zoom_ZoomFactor')
        .with(name: 'ZoomFactor', type: :dword, data: 100_000)
    end
  end

  context 'not windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe)
    end

    it 'should warn if not Windows platform' do
      expect(chef_run).to write_log(
        'Recipe ie::zoom is only available for Windows platforms!'
      )
    end
  end
end
