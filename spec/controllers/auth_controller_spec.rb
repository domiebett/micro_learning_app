require_relative '../spec_helper'

describe 'App' do
  it 'should open sign up page' do
    get '/signup'

    expect(last_response.body).to include 'First Name'
    expect(last_response.body).to include 'Last Name'
    expect(last_response.body).to include 'Email'
    expect(last_response.body).to include 'Password'
  end

  it 'should sign up user succesfully' do
    post '/signup', first_name: 'Dominic',
                    last_name: 'Bett',
                    email: 'dom@example.com',
                    password: 'password'

    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_request.path).to eq('/')
  end

  context 'incase of wrong authentication' do
    it 'should redirect back to sign up page' do
      post '/signup'

      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/signup')
    end

    it 'should show appropriate error messages' do
      post '/signup'

      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_response.body).to include('can\'t be blank')
      expect(last_response.body).to include('is too short')
      expect(last_response.body).to include('is invalid')
    end
  end
end
