require_relative '../spec_helper'
require_relative '../../app/models/category'

describe Category do
  before do
    @category = {
        name: 'programming',
        description: 'description'
    }
  end

  it 'should have a name and description' do
    category = Category.new
    expect(category.invalid?).to be_truthy
    error_messages = {
        name: [ "can't be blank", "is too short (minimum is 2 characters)"],
        description: ["can't be blank", "is too short (minimum is 5 characters)"]
    }
    expect(category.errors.messages).to eq error_messages
  end

  it 'should have be valid if all details are correct' do
    category = Category.new(@category)
    expect(category.valid?).to be_truthy
  end

  it 'should have unique name' do
    create(:category)
    category = Category.new(@category)
    expect(category.invalid?).to be_truthy

    expect(category.errors.messages).to eq name: ['has already been taken']
  end

  it 'should have many topics' do
    assoc = Category.reflect_on_association(:topics).macro
    expect(assoc).to eq :has_many
  end
end