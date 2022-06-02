# frozen_string_literal: true

# Controller for headings
class HeadingsController < ApplicationController
  before_action :set_heading, only: %i[show edit update destroy]
  before_action :require_login

  # GET /headings or /headings.json
  def index
    @headings = Heading.all
  end

  # GET /headings/1 or /headings/1.json
  def show; end

  # GET /headings/new
  def new
    @heading = Heading.new
  end

  # GET /headings/1/edit
  def edit; end

  # POST /headings or /headings.json
  def create
    @heading = Heading.new(heading_params)

    respond_to do |format|
      if @heading.save
        format.html { redirect_to heading_url(@heading), notice: 'Heading was successfully created.' }
        format.json { render :show, status: :created, location: @heading }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @heading.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /headings/1 or /headings/1.json
  def update
    respond_to do |format|
      if @heading.update(heading_params)
        format.html { redirect_to heading_url(@heading), notice: 'Heading was successfully updated.' }
        format.json { render :show, status: :ok, location: @heading }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @heading.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /headings/1 or /headings/1.json
  def destroy
    @heading.destroy

    respond_to do |format|
      format.html { redirect_to headings_url, notice: 'Heading was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_heading
    @heading = Heading.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def heading_params
    params.require(:heading).permit(:category_id, :subcategory_id)
  end

  # Require login
  def require_login
    redirect_to new_user_session_path if current_user.blank?
  end
end
