# frozen_string_literal: true

class AccessRestrictionsController < ApplicationController
  before_action :set_access_restriction, only: %i[show edit update destroy]

  # GET /access_restrictions or /access_restrictions.json
  def index
    @access_restrictions = AccessRestriction.all
  end

  # GET /access_restrictions/1 or /access_restrictions/1.json
  def show; end

  # GET /access_restrictions/new
  def new
    @access_restriction = AccessRestriction.new
  end

  # GET /access_restrictions/1/edit
  def edit; end

  # POST /access_restrictions or /access_restrictions.json
  def create # rubocop:disable Metrics/MethodLength
    @access_restriction = AccessRestriction.new(access_restriction_params)

    respond_to do |format|
      if @access_restriction.save
        format.html do
          redirect_to access_restriction_url(@access_restriction),
                      notice: 'Access restriction was successfully created.'
        end
        format.json { render :show, status: :created, location: @access_restriction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @access_restriction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /access_restrictions/1 or /access_restrictions/1.json
  def update # rubocop:disable Metrics/MethodLength
    respond_to do |format|
      if @access_restriction.update(access_restriction_params)
        format.html do
          redirect_to access_restriction_url(@access_restriction),
                      notice: 'Access restriction was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @access_restriction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @access_restriction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /access_restrictions/1 or /access_restrictions/1.json
  def destroy
    @access_restriction.destroy

    respond_to do |format|
      format.html { redirect_to access_restrictions_url, notice: 'Access restriction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_access_restriction
    @access_restriction = AccessRestriction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def access_restriction_params
    params.require(:access_restriction).permit(:jhu_id, :access_restriction_type_id, :database_id, :note, :private_url)
  end
end
