class EventsOutfitsController < ApplicationController
  # GET /events_outfits
  # GET /events_outfits.json
  def index
    @events_outfits = EventsOutfit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @events_outfits }
    end
  end

  # GET /events_outfits/1
  # GET /events_outfits/1.json
  def show
    @events_outfit = EventsOutfit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @events_outfit }
    end
  end

  # GET /events_outfits/new
  # GET /events_outfits/new.json
  def new
    @events_outfit = EventsOutfit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @events_outfit }
    end
  end

  # GET /events_outfits/1/edit
  def edit
    @events_outfit = EventsOutfit.find(params[:id])
  end

  # POST /events_outfits
  # POST /events_outfits.json
  def create
    @events_outfit = EventsOutfit.new(params[:events_outfit])

    respond_to do |format|
      if @events_outfit.save
        format.html { redirect_to @events_outfit, :notice => 'Events outfit was successfully created.' }
        format.json { render :json => @events_outfit, :status => :created, :location => @events_outfit }
      else
        format.html { render :action => "new" }
        format.json { render :json => @events_outfit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events_outfits/1
  # PUT /events_outfits/1.json
  def update
    @events_outfit = EventsOutfit.find(params[:id])

    respond_to do |format|
      if @events_outfit.update_attributes(params[:events_outfit])
        format.html { redirect_to @events_outfit, :notice => 'Events outfit was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @events_outfit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events_outfits/1
  # DELETE /events_outfits/1.json
  def destroy
    @events_outfit = EventsOutfit.find(params[:id])
    @events_outfit.destroy

    respond_to do |format|
      format.html { redirect_to events_outfits_url }
      format.json { head :ok }
    end
  end
end
