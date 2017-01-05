require 'mina/deploy'
require 'mina/git'

set :application_name, 'moex-helper'
set :domain, '...'
set :deploy_to, '...'
set :repository, 'git@github.com:miraks/moex-helper.git'
set :branch, 'master'

set :user, '...'

set :shared_dirs, fetch(:shared_dirs, []).push('_build', 'deps', 'node_modules')
set :shared_files, fetch(:shared_files, []).push('config/prod.secret.exs', 'config/prod.secret.key',
  'config/prod.secret.cookie')

def cc(str)
  comment str
  command str
end

task :environment do
end

task :setup do
  invoke :'mix:ecto_create'
end

namespace :yarn do
  desc 'Install npm dependencies'
  task install: :environment do
    cc %{yarn install}
  end

  desc 'Build assets with webpack'
  task build: :environment do
    cc %{NODE_ENV=production yarn run build}
  end
end

namespace :mix do
  desc 'Install mix dependencies'
  task deps: :environment do
    cc %{MIX_ENV=prod mix deps.get}
  end

  desc 'Assembly application release using distillery'
  task release: :environment do
    cc %{MIX_ENV=prod mix release}
  end

  desc 'Create database'
  task ecto_create: :environment do
    cc %{MIX_ENV=prod mix ecto.create}
  end

  desc 'Apply database migrations'
  task ecto_migrate: :environment do
    cc %{MIX_ENV=prod mix ecto.migrate}
  end
end

namespace :moex_helper do
  desc 'Start application'
  task start: :environment do
    cc %{_build/prod/rel/moex_helper/bin/moex_helper start}
  end

  desc 'Stop application'
  task stop: :environment do
    cc %{
      if _build/prod/rel/moex_helper/bin/moex_helper ping; then
        _build/prod/rel/moex_helper/bin/moex_helper stop
      fi
    }
  end
end

desc "Deploys the current version to the server."
task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'yarn:install'
    invoke :'yarn:build'
    invoke :'mix:deps'
    invoke :'mix:ecto_migrate'
    invoke :'mix:release'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        invoke :'moex_helper:stop'
        invoke :'moex_helper:start'
      end
    end
  end
end
