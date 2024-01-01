Rails.application.config.session_store :redis_store, servers: ENV['REDIS_URL'], expire_after: 90.minutes, key: "_#{Rails.application.class.module_parent.name.downcase}_session"
