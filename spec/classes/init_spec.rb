require 'spec_helper'
describe 'ksmb' do
  context 'with default values for all parameters' do
    it { is_expected.to contain_class('ksmb') }
  end
end
