require 'spec_helper'

describe 'minio::service', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'with all defaults' do
        let :params do
          {
            manage_service: true,
            service_provider: 'systemd',
            configuration_directory: '/etc/minio',
          }
        end
        let(:pre_condition) {
          [
            'file { "/etc/minio": ensure => "directory"}',
            'remote_file { "minio": }'
          ]
        }

        it { is_expected.to contain_service('minio') }
      end
    end
  end
end
