require 'spec_helper_acceptance'

RSpec.describe 'snmptrapd' do
  context 'defaults' do
    manifest = <<-EOPP
      class {'snmp': 
        trap_service_ensure => 'running',
        agentaddress => [ 'udp:127.0.0.1:161', ],
      }
    EOPP
    it_behaves_like 'apply_manifest_twice', manifest
    it_behaves_like 'has_process', manifest, 'snmptrapd'
  end
  context 'daemon options' do
    manifest = <<-EOPP
      class {'snmp':
        trap_service_ensure => 'running',
        snmptrapd_options => '-Ox -Lsd',
        agentaddress => [ 'udp:127.0.0.1:161', ],
      }
    EOPP
    it_behaves_like 'apply_manifest_twice', manifest
    it_behaves_like 'has_process', manifest, 'snmptrapd', ['-Ox', '-Lsd']
  end
end
