Vagrant.configure(2) do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: true
  
  config.vm.box = 'ubuntu'
  # https://cloud-images.ubuntu.com/vagrant/utopic/current/utopic-server-cloudimg-amd64-vagrant-disk1.box
  config.vm.network :private_network, ip: '111.111.111.111'

  config.vm.provider 'virtualbox' do |virtualbox|
    virtualbox.memory = 1024
    virtualbox.cpus = 2
  end
end
