root = ::File.dirname(__FILE__)
require ::File.join(root, 'main')
require 'sass/plugin/rack'

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

run App.new
