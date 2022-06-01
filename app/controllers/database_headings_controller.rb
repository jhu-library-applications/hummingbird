# frozen_string_literal: true

# Controller for database headings
class DatabaseHeadingsController < ApplicationController
  before_action :set_database_heading, only: %i[show edit update destroy]
  before_action :require_login

  # GET /database_headings or /database_headings.json
  def index
    @database_headings = DatabaseHeading.all
  end

  # GET /database_headings/1 or /database_headings/1.json
  def show; end

  # GET /database_headings/new
  def new
    @database_heading = DatabaseHeading.new
  end

  # GET /database_headings/1/edit
  def edit; end

  # POST /database_headings or /database_headings.json
  def create # rubocop:disable Metrics/MethodLength
    @database_heading = DatabaseHeading.new(database_heading_params)

    respond_to do |format|
      if @database_heading.save
        format.html do
          redirect_to database_heading_url(@database_heading), notice: 'Database heading was successfully created.'
        end
        format.json { render :show, status: :created, location: @database_heading }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @database_heading.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /database_headings/1 or /database_headings/1.json
  def update # rubocop:disable Metrics/MethodLength
    respond_to do |format|
      if @database_heading.update(database_heading_params)
        format.html do
          redirect_to database_heading_url(@database_heading), notice: 'Database heading was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @database_heading }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @database_heading.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /database_headings/1 or /database_headings/1.json
  def destroy
    @database_heading.destroy

    respond_to do |format|
      format.html { redirect_to database_headings_url, notice: 'Database heading was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_database_heading
    @database_heading = DatabaseHeading.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def database_heading_params
    params.require(:database_heading).permit(:database_id, :heading_id)
  end

  # Require login
  def require_login
    redirect_to new_user_session_path if current_user.blank?
  end
end
