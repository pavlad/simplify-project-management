class ClientsController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Client.all
    @client = Client.new
  end

  def show
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.create(client_params)
    @client.save

    redirect_to clients_path
  end

  def edit
    respond_to do |format|
      format.html { redirect_to clients_path }
      format.js
    end
  end

  def update
    @client.update(client_params)
    redirect_to clients_path
  end

  def destroy
    @client.destroy
    redirect_to clients_path
  end

  private

  def client_params
    params.require(:client).permit(:email, :name, :address, :phone, :website)
  end

  def set_client
    @client = Client.find(params[:id])
  end
end
