require_relative '../spec_helper'

describe 'App' do
  context 'when user navigates to "/dashboard"' do
    subject { last_response }
    before { get '/dashboard' }
    it { is_expected.to be_ok }
  end
end
