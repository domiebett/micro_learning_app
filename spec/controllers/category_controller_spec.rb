require_relative './../spec_helper'

describe 'App' do
  before { create(:user) }

  context 'when logged in user opens "/categories" url' do
    before do
      post '/signin', @user
      get '/categories'
    end

    it 'should respond with a page showing categories' do
      expect(last_response).to be_ok
      expect(last_response.body).to include 'programming', 'hacking', 'philosophy'
    end
  end

  context 'when non logged in user opens "/categories" url' do
    before { get '/categories' }
    subject { last_response }
    it { is_expected.to be_redirect }

    it 'should redirect back to the sign in page' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq '/signin'
    end
  end
end
