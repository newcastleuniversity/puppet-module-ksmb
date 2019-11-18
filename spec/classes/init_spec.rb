require 'spec_helper'
describe 'ksmb' do
  context 'with default values for all parameters' do
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_augeas('papersize') }
    it { is_expected.to contain_file('/etc/sudoers.d/lp') }
    it { is_expected.to contain_file('ksmb') }
    it { is_expected.to contain_file('ksmb.real') }
    it { is_expected.to contain_package('smbclient') }
  end
end
