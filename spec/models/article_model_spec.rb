require_relative '../spec_helper'
require_relative '../../app/models/article'

describe Article do

  before do
    @article = {
        title: 'ruby programming',
        url: 'url',
        description: 'description',
        author: 'author'
    }
    create(:category)
    create(:topic)
  end

  it 'should be invalid without title, description and url' do
    article = Article.new
    expect(article.invalid?).to be_truthy

    error_messages = {
        title: [ "can't be blank"],
        description: ["can't be blank"],
        url: ["can't be blank"]
    }
    expect(article.errors.messages).to eq error_messages
  end

  it 'should have a unique title' do
    create(:article)
    article = Article.new(@article)

    expect(article.invalid?).to be_truthy

    error_message = { title: ['has already been taken'] }
    expect(article.errors.messages).to eq error_message
  end

  it 'should have one topic' do
    assoc = Article.reflect_on_association(:topic)
    expect(assoc.macro).to eq(:belongs_to)
  end
end