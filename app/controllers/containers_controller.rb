class ContainersController < ApplicationController
  def show
    @container = Docker::Container.get(params[:id])
    @logs = @container.logs(stdout: true, stderr: true)
  end

  def new
    _images = Docker::Image.all

    @images = Hash.new
    _images.each_with_index do |image, index|
      @images[image.id.to_s.truncate(12, omission: '')] = image.info['RepoTags'][0]
    end
  end

  def create
    json = Hash.new
    if params[:hostname]
      json['Hostname'] = params[:hostname]
    end

    if params[:image]
      json['Image'] = params[:image]
    else
      json['Image'] = 'debian:latest'
    end

    name = Hash.new
    name['Name'] = 'Peter'
    json['HostConfig'] = Hash.new
    json['HostConfig']['Ulimits'] = name

    @container = Docker::Container.create(json)
    render :json => json
    # flash[:success] = 'Der Container wurde erfolgreich erstellt.'
    # redirect_to container_path @container.id
  end

  def start
    @container = Docker::Container.get(params[:id])
    @container.start

    @container = Docker::Container.get(params[:id])
    state = @container.info['State']['Status']

    if state == 'running'
      flash[:success] = 'Der Container wurde erfolgreich gestartet.'
      redirect_to container_path
    else
      flash[:error] = 'Der Container konnte nicht gestartet werden.'
      redirect_to container_path
    end
  end

  def stop
    @container = Docker::Container.get(params[:id])
    @container.stop

    @container = Docker::Container.get(params[:id])
    state = @container.info['State']['Status']

    if state == 'exited'
      flash[:success] = 'Der Container wurde erfolgreich gestopt.'
      redirect_to container_path
    else
      flash[:error] = 'Der Container konnte nicht gestopt werden.'
      redirect_to container_path
    end
  end

  def restart
    @container = Docker::Container.get(params[:id])
    @container.restart

    @container = Docker::Container.get(params[:id])
    state = @container.info['State']['Status']

    if state == 'running'
      flash[:success] = 'Der Container wurde erfolgreich neugestartet.'
      redirect_to container_path
    else
      flash[:error] = 'Der Container konnte nicht neugestartet werden.'
      redirect_to container_path
    end
  end

  def commit
    @container = Docker::Container.get(params[:id])
    @container.commit
    flash[:success] = 'Der Container wurde erfolgreich "committet".'
    redirect_to container_path
  end

  def remove
    @container = Docker::Container.get(params[:id])
    state = @container.info['State']['Status']
    # render :json => state
    if state == 'running'
      flash[:error] = 'Der Container muss zuerst gestopt werden.'
      redirect_to container_path
    elsif state == 'exited'
      @container.remove
      flash[:error] = 'Der Container wurde gelöscht.'
      redirect_to containers_path
    else
      flash[:error] = 'Unbekannter Fehler.'
      redirect_to container_path
    end
  end
end
