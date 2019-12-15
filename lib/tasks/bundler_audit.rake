if Rails.env.development? || Rails.env.test?
  require "bundler/audit/cli"

  namespace :bundler do
    desc "Updates the ruby-advisory-db and runs audit"
    task :audit do
      ["update", "check"].each do |command|
        Bundler::Audit::CLI.start [command]
      end
    end
  end
end
