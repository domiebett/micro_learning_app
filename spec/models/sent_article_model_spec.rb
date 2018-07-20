require_relative '../spec_helper'
require_relative '../../app/models/sent_article'

describe SentArticle do
  it 'should have one topic' do
    assoc = SentArticle.reflect_on_association(:article)
    expect(assoc.macro).to eq(:belongs_to)
  end

  it 'should have one user' do
    assoc = SentArticle.reflect_on_association(:user)
    expect(assoc.macro).to eq(:belongs_to)
  end
end