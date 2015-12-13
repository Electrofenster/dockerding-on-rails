class ImagesController < ApplicationController
  def index
    @images = Docker::Image.all
    # @search = Docker::Image.search(:term => 'htop')
  end

  def show
    @image = Docker::Image.get(params[:id])
  end

  def destroy
    if Docker::Image.exist?(params[:id])
      image = Docker::Image.get(params[:id])
      image.remove

      if !Docker::Image.exist?(params[:id])
        flash[:success] = 'Das Image wurde erfolgreich gelöscht.'
      else
        flash[:error] = 'Fehler beim löschen des Images.'
      end
    end
    redirect_to images_path
  end

  def create
    Docker::Image.create('fromImage' => params[:name])
  end

  def download
    image = Docker::Image.get(params[:id])
    file = 'public/images/'+image.id+'.tar'
    if !File.exist?(file)
      image.save(file)
    end

    download_file(file)
  end

  private

  def download_file file
    type = MIME::Types.type_for(file).first.content_type
    send_file file, :type=> type, :x_sendfile => true
  end
end
