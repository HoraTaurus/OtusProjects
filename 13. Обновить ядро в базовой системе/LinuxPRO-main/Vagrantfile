# -*- mode: ruby -*-
# vim: set ft=ruby :

ENV['VAGRANT_SERVER_URL'] = 'http://vagrant.elab.pro'
#Параметры указываются в цикле
Vagrant.configure("2") do |config|
  #Указываем, какую ОС мы будем использовать
  config.vm.box = "ubuntu/xenial64"
  #Можно указать конкретную версию сборки 
  #Номера сборок можно посмотреть в Vagrant Cloud
  #config.vm.box_version = "20220427.0.0"

  #Проброс порта с гостевой машины в хост
  #Порт 80 в созданной ВМ будет доступен нам на порту 8080 хоста
  config.vm.network "forwarded_port", guest: 80, host: 8080

  #Указываем настройки спецификации ВМ
  #Указывается в отдельном цикле
  config.vm.provider "virtualbox" do |vb|
     # Даём имя машине
     vb.name = "VagrantVM"
     #Отключаем интерфейс
     vb.gui = false
     # Указываем количество ОЗУ и ядер процессора
     vb.memory = "2048"
     vb.cpus = "2"
  end
  
  #Первоначальная настройка созданной ВМ
  #Установка и запуск Веб-сервера Apache2
  config.vm.provision "shell", inline: <<-SHELL
     sudo apt-get update
     sudo apt-get install -y apache2
  SHELL

  #Для установки/использования Ансибля
  #config.vm.provision "ansible" do |ansible|
    #ansible.playbook ='site.yml'   #файл в котором лежат настройки
  #end

end