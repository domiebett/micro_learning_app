require_relative '../spec_helper'

describe 'App' do
  context 'when logged in user open home page' do
    before do
      create(:user)
      post '/signin', email: 'bett@example.com', password: 'password'
    end
    it 'should return the home page' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to include 'Home Page'
    end
  end

  context 'when non logged in user opens homepage' do
    before { get '/' }
    it 'should redirect to signin page' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/signin')
    end
  end
end