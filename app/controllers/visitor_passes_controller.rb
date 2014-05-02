class VisitorPassesController < ApplicationController
  before_action :set_visitor_pass, only: [:show, :edit, :update, :destroy]

  # GET /visitor_passes
  # GET /visitor_passes.json
  def index
    @visitor_passes = VisitorPass.all
  end

  # GET /visitor_passes/1
  # GET /visitor_passes/1.json
  def show
  end

  # GET /visitor_passes/new
  def new
    @visitor_pass = VisitorPass.new
  end

  # GET /visitor_passes/1/edit
  def edit
  end

  # POST /visitor_passes
  # POST /visitor_passes.json
  def create
    @visitor_pass = VisitorPass.new(visitor_pass_params)

    respond_to do |format|
      if @visitor_pass.save
        format.html { redirect_to @visitor_pass, notice: 'Visitor pass was successfully created.' }
        format.json { render action: 'show', status: :created, location: @visitor_pass }
      else
        format.html { render action: 'new' }
        format.json { render json: @visitor_pass.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visitor_passes/1
  # PATCH/PUT /visitor_passes/1.json
  def update
    respond_to do |format|
      if @visitor_pass.update(visitor_pass_params)
        format.html { redirect_to @visitor_pass, notice: 'Visitor pass was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @visitor_pass.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visitor_passes/1
  # DELETE /visitor_passes/1.json
  def destroy
    @visitor_pass.destroy
    respond_to do |format|
      format.html { redirect_to visitor_passes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visitor_pass
      @visitor_pass = VisitorPass.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def visitor_pass_params
      params.require(:visitor_pass).permit(:visitor_phone_number, :active, :used)
    end
end
