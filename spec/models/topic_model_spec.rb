require_relative '../spec_helper'
require_relative '../../app/models/topic'

describe Topic do
  before do
    create(:category)
  end

  it 'should have a name' do
    topic = Topic.new
    expect(topic.invalid?).to be_truthy

    error_messages = {
      name: ["can't be blank", 'is too short (minimum is 2 characters)']
    }
    expect(topic.errors.messages).to eq error_messages
  end

  it 'should be valid if valid name is provided' do
    topic = Topic.new(name: 'topic')
    expect(topic.valid?).to be_truthy
  end

  context 'when fetch articles method is called' do
    it 'should fetch articles from api services' do
      create(:topic)
      topic = Topic.find_by(name: 'ruby')
      topic.fetch_articles
      expect(Article.count).to be > 0
    end
  end

  it 'should have many users' do
    assoc = Topic.reflect_on_association(:users).macro
    expect(assoc).to eq :has_many
  end

  it 'should have many articles' do
    assoc = Topic.reflect_on_association(:articles).macro
    expect(assoc).to eq :has_many
  end
end
