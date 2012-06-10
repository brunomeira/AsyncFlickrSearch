namespace :test do
  desc "start Watchr to RSpec"
  task :watchr do
    sh %{bundle exec watchr watchr}
  end
end

