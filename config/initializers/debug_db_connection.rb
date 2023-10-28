class DebugDbConnection
  def initialize(app)
    @app = app
  end

  def call(env)
    conn = ActiveRecord::Base.connection
    Rails.logger.debug("CONNECTION GET: #{conn}")

    @app.call(env)
  end  
end

Rails.application.middleware.insert_before(0, DebugDbConnection)