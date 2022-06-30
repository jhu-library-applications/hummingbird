# frozen_string_literal: true

# Controller for vendors
class VendorsController < ApplicationController
  before_action :set_vendor, only: %i[show edit update destroy]
  before_action :new_vendor, only: :create
  before_action :require_login

  # GET /vendors or /vendors.json
  def index
    default_sort = :asc
    if params[:search] && params[:sort].nil?
      @vendors ||= Vendor.where('brand_name ILIKE ?',
                                "%#{params[:search]}%").order('brand_name ASC').page(params[:page])
    elsif params[:search] && params[:sort] == 'asc'
      @vendors ||= Vendor.where('brand_name ILIKE ?',
                                "%#{params[:search]}%").order('brand_name ASC').page(params[:page])
    elsif params[:search] && params[:sort] == 'desc'
      @vendors ||= Vendor.where('brand_name ILIKE ?',
                                "%#{params[:search]}%").order('brand_name DESC').page(params[:page])
    else
      @vendors = Vendor.all.order(brand_name: params[:sort] || default_sort).page(params[:page])
    end
  end

  # GET /vendors/1 or /vendors/1.json
  def show; end

  # GET /vendors/new
  def new
    @vendor = Vendor.new
    authorize! :create, @vendor
  end

  # GET /vendors/1/edit
  def edit
    authorize! :update, @vendor
  end

  # POST /vendors or /vendors.json
  def create
    authorize! :create, @vendor

    respond_to do |format|
      if @vendor.save
        format.html { redirect_to vendor_url(@vendor), notice: 'Vendor was successfully created.' }
        format.json { render :show, status: :created, location: @vendor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vendors/1 or /vendors/1.json
  def update
    authorize! :update, @vendor
    respond_to do |format|
      if @vendor.update(vendor_params)
        format.html { redirect_to vendor_url(@vendor), notice: 'Vendor was successfully updated.' }
        format.json { render :show, status: :ok, location: @vendor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendors/1 or /vendors/1.json
  def destroy
    authorize! :destroy, @vendor
    @vendor.destroy

    respond_to do |format|
      format.html { redirect_to vendors_url, notice: 'Vendor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vendor
    @vendor = Vendor.find(params[:id])
  end

  def new_vendor
    @vendor = Vendor.new(vendor_params)
  end

  # Only allow a list of trusted parameters through.
  def vendor_params
    params.require(:vendor).permit(:brand_name)
  end

  # Require login
  def require_login
    redirect_to new_user_session_path if current_user.blank?
  end
end
