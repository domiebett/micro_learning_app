require 'sinatra'

module Sinatra
  module ParamHelper
    def accept_params(params, *args)
      is_allowed = ->(key, _value) { args.include? key.to_sym }
      params.select(&is_allowed)
    end
  end

  helpers ParamHelper
end
