require_relative '../spec_helper'
require_relative '../../app/models/user'

describe 'User' do

  it 'should have first name, last_name, email and password_hash' do
    user = User.new
    expect(user.invalid?).to be_truthy

    error_messages = {
        email: ["can't be blank", "is invalid"],
        first_name: ["can't be blank", "is too short (minimum is 2 characters)"],
        last_name: ["can't be blank", "is too short (minimum is 2 characters)"],
        password_hash: ["is too short (minimum is 6 characters)"],
    }
    expect(user.errors.messages).to eq error_messages
  end

  it 'should be valid if all data is provided' do
    user = User.new(@user)
    expect(user.valid?).to be_truthy
  end

  it 'email should be unique' do
    create(:normal_user)
    user = User.new(@user)
    expect(user.invalid?).to be_truthy
    expect(user.errors.messages).to eq email: ['has already been taken']
  end
end
