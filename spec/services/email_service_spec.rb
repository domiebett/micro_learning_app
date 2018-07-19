require_relative '../spec_helper'
require_relative '../../app/services/email'
require_relative '../mocks/article_mock'
require 'pony'

describe Email do
  before do
    @email = Email.new('user', 'dom@example.com')
    @email.stub(:mail)
    @article = Article.new
  end

  it 'should send email through Pony' do
    @email.send_article(@article)
    expect(@email).to have_received(:mail)
  end
end
