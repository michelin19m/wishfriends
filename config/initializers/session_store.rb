Rails.logger.debug "Session store configured: #{Rails.application.config.session_store}"
Rails.application.config.session_store :cookie_store, key: '_wishfriends_session'
