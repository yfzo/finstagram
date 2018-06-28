configure do
  # Log queries to STDOUT in development
  if Sinatra::Application.development?
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  

    set :database, {
    adapter: "sqlite3",
    database: "db/db.sqlite3"
    }
  else
    db = URI.parse(ENV['DATABASE_URL'] || 'postgres://jfbmdpsldrlsfs:9f3028d262a1d52333b140bf6572b6bdf3105172af66aef72cfc8ecf0c1ed49b@ec2-54-235-196-250.compute-1.amazonaws.com:5432/dalo20ntu1kk8p
')
    set :database, {
    adapter: "postgresql",
    host: db.host,
    username: db.user,
    password: db.password,
    database: db.path[1..-1],
    encoding: "utf8"
    }
    # Load all models from app/models, using autoload instead of require
    # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
    
  end
  
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
      filename = File.basename(model_file).gsub('.rb', '')
      autoload ActiveSupport::Inflector.camelize(filename), model_file
  end
  
end
