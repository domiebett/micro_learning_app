require_relative '../spec_helper'
require_relative '../../app/helpers/param_helper'

describe 'ParamHelper' do
  subject { Class.new { include Sinatra::ParamHelper } }
  before do
    @param_helper = subject.new
    @params = { name: 'Name', email: 'Email', password: 'Password' }
  end

  it 'should only accept params defined' do
    accepted_params = @param_helper.accept_params @params, :email, :password
    expect(accepted_params).to eq({ email: 'Email', password: 'Password'})
  end
end
