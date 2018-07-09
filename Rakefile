require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require_relative 'main'

namespace :db do
  namespace :test do
    task prepare: :environment do
      Rake::Task['db:seed'].invoke
    end
  end
end
