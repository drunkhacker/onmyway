# Be sure to restart your server when you modify this file.

Doorbell::Application.config.session_store :redis_session_store, key: '_doorbell_session', expire_after: 1.year
