require_relative '../spec_helper'

describe 'App' do
  context 'when logged in user opens home page url' do
    before do
      create(:normal_user)
      create(:category)
      post '/signin', @user
    end

    it 'should open the homepage' do
      get '/'
      expect(last_response).to be_ok
      expect(last_request.path).to eq '/'
    end

  end
end