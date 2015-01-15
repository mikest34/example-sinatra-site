require "sinatra/base"
require "sinatra/reloader"

module DemoSite
  class App < Sinatra::Base

    # If you want to set password protection for a particular environment,
    # uncomment this and set the username/password:
    #if ENV['RACK_ENV'] == 'staging'
      #use Rack::Auth::Basic, "Please sign in" do |username, password|
        #[username, password] == ['theusername', 'thepassword']
      #end
    #end

    configure :development do
      register Sinatra::Reloader
    end

    configure do
      # Set your Google Analytics ID here if you have one:
      # set :google_analytics_id, 'UA-12345678-1'
      set :views, 'app/views' 
      set :layouts_dir, 'app/views/_layouts'
      set :partials_dir, 'app/views/_partials'
    end

    helpers do
      def show_error (code = 404, message = 'Not Found')
        status code
        @page_name = message
        @page_title = message
        @page_header = @page_title
        erb :'error', :layout => :template,
                    :layout_options => {:views => settings.layouts_dir}
      end
    end


    not_found do
      show_error(404)
    end


    # Redirect any URLs without a trailing slash to the version with.
    get %r{(/.*[^\/])$} do
      redirect "#{params[:captures].first}/"
    end


    get '/' do
      @page_name = 'home'
      @page_title = 'Home page'
      @page_header = @page_title
      @page_subhead = 'You are visiting the example site!'
      erb :index,
        :layout => :template,
        :layout_options => {:views => settings.layouts_dir}
    end


    # Routes for pages that have unique things...

    get '/special/' do
      require_relative 'app/models/test'
      @page_name = 'special'
      @page_title = 'A special page'
      @page_header = @page_title
      @page_subhead = 'You are visiting the example site!'
      @time = Time.now
      @test = Test.getTestData
      erb :special,
        :layout => :template,
        :layout_options => {:views => settings.layouts_dir}
    end


    # Catch-all for /something/else/etc/ pages which just display templates.
    get %r{/([\w\/-]+)/$} do |path|
      pages = {
        'help' => {
          :page_name => 'help',
          :title => 'Help',
        },
        'help/accounts' => {
          :page_name => 'help_accounts',
          :title => 'Accounts Help',
        },
        # etc
      }
      if pages.has_key?(path)
        @page_name = pages[path][:page_name]
        @page_title = pages[path][:title]
        @page_header = @page_title
        layout = :template
        if pages[path].has_key?(:layout)
          layout = pages[path][:layout].to_sym
        end
        erb @page_name.to_sym,
          :layout => layout,
          :layout_options => {:views => settings.layouts_dir}
      else
        show_error(404)
      end
    end

  end
end
