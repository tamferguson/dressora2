class ItemsController < ApplicationController
  before_filter :require_current_user, :only => :show
    before_filter :require_user
  # GET /items
  # GET /items.json
  def index
    @items = current_user.items.all
    @tops = current_user.items.select{|i| i.category.name == "Top"} 
    @bottoms = current_user.items.select{|i| i.category.name == "Bottom"} 
    @accessories = current_user.items.select{|i| i.category.name == "Accessory"} 
    @shoes = current_user.items.select{|i| i.category.name == "Shoes"} 
    #i could do Item.all and put if else for each category to do only one SQL query

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])
    @item.user = current_user

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, :notice => 'Item was successfully created.' }
        format.json { render :json => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.json { render :json => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, :notice => 'Item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :ok }
    end
  end
  
  private

  def require_current_user
    @item = current_user.items.find_by_id(params[:id])
    if !@item
      redirect_to items_url, :notice => "That's not yours!"
    end
  end
  
  def fb_response
    logger.debug "fb_response called"
    user = User.find(session[:user_id])
    logger.debug "user found"
    user.fb_access_token = params["access_token"]
    user.fb_uid = params["uid"]
    logger.debug "DEBUG #{user.id} -- #{params["uid"]}"
    user.save!
    logger.debug "saved"
  end
end
