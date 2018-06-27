require 'sinatra'

module Sinatra
  module HtmlHelper
    def styles(*args)
      styles = []
      styles << args

      styles.flatten.uniq.map do |style|
        %(<link rel="stylesheet" type="text/css"
              href="stylesheets/#{style}.css" />)
      end.join
    end
  end

  helpers HtmlHelper
end
