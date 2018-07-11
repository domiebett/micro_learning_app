require_relative './../spec_helper'

describe 'App' do
  before { create(:normal_user) }

  context 'when logged in user opens "/categories" url' do
    before do
      post '/signin', @user
      get '/categories'

      @category = {
          name: 'programming'
      }
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

  context 'when non admin attempts to add a category' do
    before do
      post '/signin', @user
      post '/categories', @topics
    end
    it 'should return 401 response' do
      expect(last_response.status).to be 401
    end
  end

  context 'when admin attempts to add a category' do
    before do
      create(:admin)
      post '/signin', @admin
      post '/categories'
    end

    subject { last_response }
    it { is_expected.to be_redirect }

    before { post '/categories' }
    it 'should flag empty topics' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_response.body).to include 'You did not enter a valid category'
    end
  end
end
