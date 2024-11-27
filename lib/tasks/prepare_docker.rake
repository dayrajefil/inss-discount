# frozen_string_literal: true

namespace :docker do
  desc 'Remove all containers, images, and rebuild the environment'
  task prepare_server: :environment do
    puts 'Stopping and removing all containers...'
    system('docker stop $(docker ps -aq) && docker rm $(docker ps -aq)')

    puts 'Removing all images...'
    system('docker rmi -f $(docker images -aq)')

    puts 'Cleaning up unused volumes...'
    system('docker volume prune -f')

    puts 'Cleaning up unused networks...'
    system('docker network prune -f')

    puts 'Rebuilding containers...'
    system('docker-compose up --build')
  end
end
