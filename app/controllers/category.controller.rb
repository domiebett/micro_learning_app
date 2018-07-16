require 'sinatra'
require 'slim'

require_relative '../models/category'

class App < Sinatra::Application
  get '/categories', auth: true do
    @categories = Category.all
    slim :"category/view"
  end

  post '/categories', auth: true, admin: true do
    @category = Category.new(name: params[:name])
    flash_warning 'You did not enter a valid category' unless @category.save
    redirect '/categories'
  end

  delete '/categories/:category_id', auth: true, admin: true do
    category = Category.find_by(id: params[:category_id])

    flash_notice 'You deleted the category successfully' if category.destroy

    redirect '/categories'
  end
end
