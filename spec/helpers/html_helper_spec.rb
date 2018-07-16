require_relative '../spec_helper'
require_relative '../../app/helpers/html.helper'

describe 'HtmlHelper' do
  subject { Class.new { include Sinatra::HtmlHelper } }

  before do
    @html_helper = subject.new
  end

  it ':styles method should create style tag' do
    expect(@html_helper.styles :style).to include '<link',
                                                   'href="/stylesheets/style.css"'
  end

  it ':scripts method should create script tag' do
    expect(@html_helper.scripts :script).to include '<script',
                                                    'src="/javascript/script.js"'
  end

  it ':use_method should create correct tag' do
    put_method = %(<input type="hidden" name="_method" value="put" />)
    expect(@html_helper.use_method :put).to eq put_method
  end

  it ':input method should create input correctly' do
    expect(@html_helper.input :name).to include '<input',
                                                'type="text"'
    expect(@html_helper.input :password).to include 'type="password"'
  end

  it ':submit_button method to create a submit button' do
    expect(@html_helper.submit_button "Submit").to include '<input',
                                                           'type="submit"',
                                                           'value="Submit"'
  end
end