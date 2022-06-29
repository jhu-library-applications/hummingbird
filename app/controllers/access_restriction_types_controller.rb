# frozen_string_literal: true

class AccessRestrictionTypesController < ApplicationController
  before_action :set_access_restriction_type, only: %i[show edit update destroy]

  # GET /access_restriction_types or /access_restriction_types.json
  def index
    @access_restriction_types = AccessRestrictionType.all
  end

  # GET /access_restriction_types/1 or /access_restriction_types/1.json
  def show; end

  # GET /access_restriction_types/new
  def new
    @access_restriction_type = AccessRestrictionType.new
  end

  # GET /access_restriction_types/1/edit
  def edit; end

  # POST /access_restriction_types or /access_restriction_types.json
  def create # rubocop:disable Metrics/MethodLength
    @access_restriction_type = AccessRestrictionType.new(access_restriction_type_params)

    respond_to do |format|
      if @access_restriction_type.save
        format.html do
          redirect_to access_restriction_type_url(@access_restriction_type),
                      notice: 'Access restriction type was successfully created.'
        end
        format.json { render :show, status: :created, location: @access_restriction_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @access_restriction_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /access_restriction_types/1 or /access_restriction_types/1.json
  def update # rubocop:disable Metrics/MethodLength
    respond_to do |format|
      if @access_restriction_type.update(access_restriction_type_params)
        format.html do
          redirect_to access_restriction_type_url(@access_restriction_type),
                      notice: 'Access restriction type was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @access_restriction_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @access_restriction_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /access_restriction_types/1 or /access_restriction_types/1.json
  def destroy
    @access_restriction_type.destroy

    respond_to do |format|
      format.html do
        redirect_to access_restriction_types_url, notice: 'Access restriction type was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_access_restriction_type
    @access_restriction_type = AccessRestrictionType.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def access_restriction_type_params
    params.require(:access_restriction_type).permit(:type_label, :note, :private)
  end
end
