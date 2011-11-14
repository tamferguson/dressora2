class OutfitsController < ApplicationController
  before_filter :require_current_user, :only => :show
  before_filter :require_user

  # GET /outfits
  # GET /outfits.json
  def index
    @outfits = current_user.outfits.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @outfits }
    end
  end

  # GET /outfits/1
  # GET /outfits/1.json
  def show
    @outfit = Outfit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @outfit }
    end
  end

  # GET /outfits/new
  # GET /outfits/new.json
  def new
    @outfit = Outfit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @outfit }
    end
  end

  # GET /outfits/1/edit
  def edit
    @outfit = Outfit.find(params[:id])
  end

  # POST /outfits
  # POST /outfits.json
  def create
    @outfit = Outfit.new(params[:outfit])
    @outfit.user = current_user
    
    respond_to do |format|
      if @outfit.save
        format.html { redirect_to @outfit, :notice => 'Outfit was successfully created.' }
        format.json { render :json => @outfit, :status => :created, :location => @outfit }
      else
        format.html { render :action => "new" }
        format.json { render :json => @outfit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /outfits/1
  # PUT /outfits/1.json
  def update
    @outfit = Outfit.find(params[:id])

    respond_to do |format|
      if @outfit.update_attributes(params[:outfit])
        format.html { redirect_to @outfit, :notice => 'Outfit was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @outfit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /outfits/1
  # DELETE /outfits/1.json
  def destroy
    @outfit = Outfit.find(params[:id])
    @outfit.destroy

    respond_to do |format|
      format.html { redirect_to outfits_url }
      format.json { head :ok }
    end
  end
  
  private
  
  def require_current_user
    @outfit = current_user.outfits.find_by_id(params[:id])
    if !@outfit
      redirect_to outfits_url, :notice => "That's not yours!"
    end
  end  
end
