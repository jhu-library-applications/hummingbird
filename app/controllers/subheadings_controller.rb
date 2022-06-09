# frozen_string_literal: true

class SubheadingsController < ApplicationController
  before_action :set_subheading, only: %i[show edit update destroy]
  before_action :require_login

  # GET /subheadings or /subheadings.json
  def index
    @subheadings = Subheading.all
  end

  # GET /subheadings/1 or /subheadings/1.json
  def show; end

  # GET /subheadings/new
  def new
    @subheading = Subheading.new
  end

  # GET /subheadings/1/edit
  def edit; end

  # POST /subheadings or /subheadings.json
  def create
    @subheading = Subheading.new(subheading_params)

    respond_to do |format|
      if @subheading.save
        format.html { redirect_to subheading_url(@subheading), notice: 'Subheading was successfully created.' }
        format.json { render :show, status: :created, location: @subheading }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subheading.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subheadings/1 or /subheadings/1.json
  def update
    respond_to do |format|
      if @subheading.update(subheading_params)
        format.html { redirect_to subheading_url(@subheading), notice: 'Subheading was successfully updated.' }
        format.json { render :show, status: :ok, location: @subheading }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subheading.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subheadings/1 or /subheadings/1.json
  def destroy
    @subheading.destroy

    respond_to do |format|
      format.html { redirect_to subheadings_url, notice: 'Subheading was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Require login
  def require_login
    redirect_to new_user_session_path if current_user.blank?
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_subheading
    @subheading = Subheading.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def subheading_params
    params.require(:subheading).permit(:label)
  end
end
