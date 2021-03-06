require_relative '../spec_helper'
require_relative '../../app/models/article'

describe 'App' do
  before do
    create(:normal_user)
    create(:category)
    @topics = {
        topics: %w[ruby],
        category_name: 'programming'
    }
    allow(Thread).to receive(:new)
  end

  context 'when logged in user accesses "/topics/:category" url' do
    before do
      create(:topic)
      post '/signin', @user
      get '/topics/programming'
    end

    it 'should show the topics for that category' do
      expect(last_response).to be_ok
      expect(last_response.body).to include 'ruby'
    end
  end

  context 'when logged in user selects topics' do
    before do
      create(:topic)
      post '/signin', @user
      put '/topics/user', @topics
    end

    it 'should show topics selected on homepage' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq '/'
      expect(last_response.body).to include 'ruby'
    end
  end

  context 'when non logged in user accesses "/topics:category" url' do
    before { get '/topics/programming' }

    it 'should redirect back to sign in page' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq '/dashboard'
    end
  end

  context 'when non-admin attempts to add a topic' do
    before do
      post '/signin', @user
      post '/topics', @topics
    end

    it 'should return 401 response' do
      expect(last_response.status).to be 401
    end
  end

  context 'when admin attempts to add a topic' do
    before do
      create(:admin)
      post '/signin', @admin
      post '/topics', @topics
    end

    subject { last_response }
    it { is_expected.to be_redirect }

    before { post '/topics', {category_name: 'programming'}}
    it 'should flag empty topics' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_response.body).to include 'You did not enter a valid topic'
    end
  end

  context 'when user removes topic from selected topics' do
    before do
      create(:topic)
      post '/signin', @user
      put '/topics/user', @topics
      delete '/topics/user/1'
    end

    it 'should remove topic successfully' do
      follow_redirect!
      expect(last_response.body).to_not include 'ruby'
    end
  end

  context 'when admin deletes a topic' do
    before do
      post '/signin', @admin
      post '/topics', @topics
      delete '/topics/1'
    end

    it 'should not display the topic anymore for admin' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_response.body).to_not include 'ruby'
    end

  end

  context 'when non admin deletes a topic' do
    before do
      post '/signin', @admin
      post '/topics', @topics
    end

    it 'should return 401 for normal user' do
      post '/signin', @user
      delete '/topics/1'
      expect(last_response.status).to eq 401
    end
  end
end