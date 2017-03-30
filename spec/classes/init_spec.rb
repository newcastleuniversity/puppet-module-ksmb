require 'spec_helper'
describe 'ksmb' do
  context 'with default values for all parameters' do
    it { should contain_class('ksmb') }
  end
end
