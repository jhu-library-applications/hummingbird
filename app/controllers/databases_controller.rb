# frozen_string_literal: true

# Controller for Databases
class DatabasesController < ApplicationController
  before_action :set_database, only: %i[show edit update destroy]
  before_action :new_database, only: :create
  before_action :require_login

  # GET /databases or /databases.json
  def index
    @databases = Database.all
  end

  # GET /databases/1 or /databases/1.json
  def show; end

  # GET /databases/new
  def new
    @database = Database.new
    authorize! :create, @database
  end

  # GET /databases/1/edit
  def edit
    authorize! :update, @database
  end

  # POST /databases or /databases.json
  def create
    authorize! :create, @database
    respond_to do |format|
      if @database.save
        format.html { redirect_to database_url(@database), notice: 'Database was successfully created.' }
        format.json { render :show, status: :created, location: @database }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @database.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /databases/1 or /databases/1.json
  def update
    authorize! :update, @database
    respond_to do |format|
      if @database.update(database_params)
        format.html { redirect_to database_url(@database), notice: 'Database was successfully updated.' }
        format.json { render :show, status: :ok, location: @database }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @database.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /databases/1 or /databases/1.json
  def destroy
    authorize! :destroy, @database
    @database.destroy

    respond_to do |format|
      format.html { redirect_to databases_url, notice: 'Database was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_database
    @database = Database.find(params[:id])
  end

  def new_database
    @database = Database.new(database_params)
  end

  # Only allow a list of trusted parameters through.
  def database_params
    params.require(:database).permit(:vendor_id, :jhu_id, :name, :url, :enable_proxy, :description, :internal_note)
  end

  # Require login
  def require_login
    redirect_to new_user_session_path if current_user.blank?
  end
end
