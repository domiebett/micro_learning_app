require 'sinatra'
require 'slim'

require_relative '../models/category'

class App < Sinatra::Application
  get '/categories', auth: true do
    @categories = Category.all
    slim :"category/view"
  end
end