# -*- mode: ruby -*-
# vi: set ft=ruby :

# WORK IN PROGRESS
# Vagrantfile in case I move from Heroku
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "www" do |www|
    config.vm.provider        = 'docker' do |docker|
      docker.image            = "bjjb/ballinloughdentalcare"
      docker.name             = "ballinloughdentalcare"
      docker.create_args      = %w(-i -t)
      docker.cmd              = %w(foreman start)
      docker.remains_running  = false
      docker.ports            = ['5000:5000']
    end
  end
end
