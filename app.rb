require 'sinatra'
require 'i18n'
require 'yaml'

I18n.enforce_available_locales = true
I18n.load_path = Dir["locale/*.yml"]

pages = Dir[File.dirname(__FILE__) + "/views/*.haml"].map do |f|
  File.basename(f, ".haml")
end - %w(layout)

set :pages, pages

configure do
  # Called once
end

before do
  # Called before each request
end

helpers do
  def t(*args)
    I18n.translate(*args)
  end

  def link_to(text, attrs)
    attrs = attrs.map { |k, v| "#{k}='#{v}'" }.join(' ')
    "<a %s>%s</a>" % [ attrs, text ]
  end
end

get '/' do
  haml :index
end

get "/debug" do
  content_type :txt
  {
    i18n: I18n.available_locales
  }.to_yaml
end

pages.each do |page|
  get "/#{page}" do
    haml :"#{page}"
  end
end
