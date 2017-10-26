module Backend
  class BudgetApp < Padrino::Application
    use IdentityMap
    enable :sessions
    register Padrino::Cache
    enable :caching

    # здесь же надо будет и проверку авторизации сделать
	def self.included(controller)
		controller.extend self
	end

	def self.controller_namespace(controller)
		controller.name.underscore
	end

    def self.rest_routes(klass, namespace)
      # индекс
      puts "setting route #{namespace} for #{klass}"
	  get namespace do
        @objects = klass.all, params
        @objects.to_json
      end

      # явное создание объекта
      post "#{namespace}/new" do
        object = klass.create params[:object]
        object.to_json
      end

      # апдейт или создание
      post "#{namespace}/:id" do |id|
        object = klass.first_or_create(id) || klass.first_or_create(id)
        object.update params[:object]
        object.to_json
      end

      post "#{namespace}/:name" do |id|
        object = klass.first_or_create(id) || klass.first_or_create(id)
        object.update params[:object]
        object.to_json
      end

      post "#{namespace}/:username" do |id|
        object = klass.first_or_create(id) || klass.first_or_create(id)
        object.update params[:object]
        object.to_json
      end

      # апдейт
      put "#{namespace}/:id" do |id|
        halt 404 unless object = klass.get(id)
        object.update params[:object]
        object.to_json
      end

      put "#{namespace}/:name" do |id|
        halt 404 unless object = klass.get(id)
        object.update params[:object]
        object.to_json
      end

      put "#{namespace}/:username" do |id|
        halt 404 unless object = klass.get(id)
        object.update params[:object]
        object.to_json
      end

      get "#{namespace}/:id" do |id|
        halt 404 unless object = klass.get(id)
        object.to_json
      end

      get "#{namespace}/:name" do |id|
        halt 404 unless object = klass.get(id)
        object.to_json
      end

      get "#{namespace}/:username" do |id|
        halt 404 unless object = klass.get(id)
        object.to_json
      end

      delete "#{namespace}/:id" do |id|
        klass.get!(id).destroy
      end

      delete "#{namespace}/:name" do |id|
        klass.get!(id).destroy
      end

      delete "#{namespace}/:username" do |id|
        klass.get!(id).destroy
      end
    end

    ##
    # Caching support.
    #
    #
    # You can customize caching store engines:
    #
    # set :cache, Padrino::Cache.new(:LRUHash) # Keeps cached values in memory
    # set :cache, Padrino::Cache.new(:Memcached) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Memcached, :server => '127.0.0.1:11211', :exception_retry_limit => 1)
    # set :cache, Padrino::Cache.new(:Memcached, :backend => memcached_or_dalli_instance)
    set :cache, Padrino::Cache.new(:Redis) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Redis, :host => '127.0.0.1', :port => 6379, :db => 0)
    # set :cache, Padrino::Cache.new(:Redis, :backend => redis_instance)
    # set :cache, Padrino::Cache.new(:Mongo) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Mongo, :backend => mongo_client_instance)
    # set :cache, Padrino::Cache.new(:File, :dir => Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
    #

    ##
    # Application configuration options.
    #
    # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    set :show_exceptions, true # Shows a stack trace in browser (default for development)
    # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false            # Reload application files (default in development)
    # set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, 'bar'       # Set path for I18n translations (default your_apps_root_path/locale)
    # disable :sessions             # Disabled sessions by default (enable if needed)
    # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    ##
    # You can configure for a specified environment like:
    #
    #   configure :development do
    #     set :foo, :bar
    #     disable :asset_stamp # no asset timestamping for dev
    #   end
    #

    ##
    # You can manage errors like:
    #
    #   error 404 do
    #     render 'errors/404'
    #   end
    #
    #   error 500 do
    #     render 'errors/500'
    #   end
    #
  end
end
