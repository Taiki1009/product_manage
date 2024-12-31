require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    # config.generators.system_tests = nil

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,            # RSpecのfixtures（Factory Botを使うならtrue推奨）
        view_specs: false,         # ビュースペックを生成しない
        helper_specs: false,       # ヘルパースペックを生成しない
        routing_specs: false,      # ルーティングスペックを生成しない
        controller_specs: true,    # コントローラスペックを生成したい場合はtrue
        request_specs: true       # リクエストスペックを生成しない（必要に応じてtrue/false）

      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
  end
end
