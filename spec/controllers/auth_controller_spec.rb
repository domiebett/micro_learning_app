require_relative '../spec_helper'

describe 'App' do
  before do
    @user = {
      first_name: 'Dominic',
      last_name: 'Bett',
      email: 'bett@example.com',
      password: 'password'
    }
  end

  context 'when user opens signup url' do
    before { get '/signup' }
    subject { last_request.path }
    it { is_expected.to eq('/signup') }
  end

  context 'when user enters correct details' do
    before { post '/signup', @user }

    it 'should sign them up successfully' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/')
    end
  end

  context 'when user enters wrong details' do
    before { post '/signup' }

    it 'should redirect back to sign up page' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/signup')
      expect(last_response.body).to include 'can\'t be blank',
                                            'is too short',
                                            'is invalid'
    end
  end

  context 'when user opens sign in url' do
    before { get '/signin' }
    subject { last_request.path }
    it { is_expected.to eq('/signin') }
  end

  context 'when user enters correct sign in details' do
    before do
      create(:user)
      post '/signin', @user
    end

    it 'should sign in user successfully' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/')
    end
  end

  context 'when user enters incorrect sign in details' do
    before do
      post '/signin'
    end

    subject { last_response }
    it { is_expected.to be_redirect }

    it 'should display error for wrong email' do
      post '/signin', email: 'wrong@example.com', password: 'password'
      follow_redirect!
      expect(last_response.body).to include 'Email is not registered. Please sign up'
    end

    before do
      create(:user)
      post '/signin', email: 'bett@example.com', password: 'wrong_password'
    end
    it 'should display error for wrong password' do
      follow_redirect!
      expect(last_response.body).to include 'You entered wrong email or password'
    end
  end
end
