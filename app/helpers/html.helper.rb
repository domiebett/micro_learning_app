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

    def input(name, type = 'text', value = '')
      display_name = name.to_s.split('_').map(&:capitalize).join(' ')
      %(
      <div class="text_input_holder" id="#{name}_text_input_holder">
        <label for="#{name}_text_input">#{display_name} : </label><br>
        <input class="input_field"
                type="#{type}"
                id="#{name}_text_input"
                name="#{name}"
                placeholder="Enter #{display_name}"
                value="#{value}" />
      </div>
      )
    end

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
  end

  helpers HtmlHelper
end
