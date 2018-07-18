require 'sinatra'

module Sinatra
  module HtmlHelper

    HTML_METHODS = %w[PUT PATCH DELETE].freeze

    # Builds input that makes form send requests other that POST.
    def use_method(method = 'PUT')
      method = HTML_METHODS.include?(method.to_s.upcase) ? method : 'GET'
      %(<input type="hidden" name="_method" value="#{method}" />)
    end

    # Creates a button send requests other than get.
    def button_to(value, method, route)
      %(
        <form method="POST" action="#{route}">
          #{use_method(method)}
          #{submit_button(value)}
        </form>
      )
    end

    # Creates link attributes for all styles provided.
    def styles(*args)
      styles = []
      styles << args

      styles.flatten.uniq.map do |style|
        %(<link rel="stylesheet" type="text/css"
              href="/stylesheets/#{style}.css" />)
      end.join
    end

    # Creates script attributes for all scripts provided
    def scripts(*args)
      scripts = []
      scripts << args

      scripts.flatten.uniq.map do |script|
        %(<script type="text/javascript"
              src="/javascript/#{script}.js"></script>)
      end.join
    end

    # Creates an custom input field that takes care of all bulky work.
    def input(name, args = {})
      args[:type] ||= %w[password].include?(name.to_s) ? name : 'text'
      args[:value] ||= ''
      args[:errors] ||= []

      errors = args[:errors].map do |error|
        %(<li class="error">#{error}</li>)
      end.join

      display_name = name.to_s.split('_').map(&:capitalize).join(' ')
      generate_input(name, display_name, args, errors)
    end

    def text_area(name)
      display_name = name.to_s.split('_').map(&:capitalize).join(' ')
      %( <div class="text_area_holder" id="#{name}_text_area_holder">
        <label for="#{name}_text_area">#{display_name} : </label><br>
        <textarea class="input_field"
                id="#{name}_text_area"
                name="#{name}"
                placeholder="Enter #{display_name}"></textarea>
      </div> )
    end

    def generate_input(name, display_name, args, errors = [])
      %( <div class="text_input_holder" id="#{name}_text_input_holder">
        <label for="#{name}_text_input">#{display_name} : </label><br>
        <input class="input_field #{'input_error' unless errors.empty?}"
                type="#{args[:type]}"
                id="#{name}_text_input"
                name="#{name}"
                placeholder="Enter #{display_name}"
                value="#{args[:value]}" />
        <div class="errors"><ul>#{errors unless errors.empty?}</ul></div>
      </div> )
    end

    # Creates a submit button for a form.
    def submit_button(submit_button_value)
      submit_button = %(
        <input class="button
                submit_button"
                type="submit"
                value="#{submit_button_value}"/>
      )

      %(
      <div class="submit_button_holder">
        #{submit_button}
      </div>
      )
    end

    # Creates errors for input fields
    def error_field(name)
      return '' if name.to_sym == :password
      session[:error_fields] ? session[:error_fields][name.to_sym] : ''
    end
  end

  helpers HtmlHelper
end
