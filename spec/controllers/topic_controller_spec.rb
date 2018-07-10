require_relative '../spec_helper'

describe 'App' do
  before do
    create(:user)
    @topics = {
        topics: %w[ruby java python],
        category: 'programming'
    }
  end

  context 'when logged in user accesses "/topics/:category" url' do
    before do
      post '/signin', @user
      get '/topics/programming'
    end

    it 'should show the topics for that category' do
      expect(last_response).to be_ok
      expect(last_response.body).to include 'ruby', 'java', 'python', 'go'
    end
  end

  context 'when logged in user selects topics' do
    before do
      post '/signin', @user
      post '/topics', @topics
    end

    it 'should show topics selected on homepage' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq '/'
      expect(last_response.body).to include 'ruby', 'java', 'python'
    end
  end

  context 'when non logged in user accesses "/topics:category" url' do
    before { get '/topics/programming' }

    it 'should redirect back to sign in page' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq '/signin'
    end
  end
end