require 'spec_helper'
describe 'ksmb' do
  context 'with default values for all parameters' do
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('ksmb::config') }
    it { is_expected.to contain_class('ksmb::install') }
  end
end
