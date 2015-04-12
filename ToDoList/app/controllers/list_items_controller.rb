class ListItemsController < ApplicationController
  before_filter :find_list
  before_action :set_list_item, only: [:show, :edit, :update, :destroy]

  # GET /list_items
  # GET /list_items.json
  def index
    @list_items = ListItem.all
    @list_items=@list_items.order('list_items.position ASC')
    if ["move_lower", "move_higher", "move_to_top", "move_to_bottom"].include?(params[:method]) and params[:id] =~ /^\d+$/

      ListItem.find(params[:id]).send(params[:method])

      #redirect_to lists_url
      redirect_to list_path(@list)
    end
  end

  # GET /list_items/1
  # GET /list_items/1.json
  def show
  end

  # GET /list_items/new
  def new
    @list_item = ListItem.new
  end

  # GET /list_items/1/edit
  def edit
  end

  # POST /list_items
  # POST /list_items.json
  def create

    @list_item = @list.list_items.create!(list_item_params)
    #@list_item = @list.list_items.create!(params[:list_item])

    respond_to do |format|
      if @list_item.save
        format.html { redirect_to list_path(@list), notice: 'List item was successfully created.' }
        format.json { render :show, status: :created, location: @list_item }
      else
        format.html { render :new }
        format.json { render json: @list_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /list_items/1
  # PATCH/PUT /list_items/1.json
  def update
    respond_to do |format|
      if @list_item.update(list_item_params)
        format.html { redirect_to @list_item, notice: 'List item was successfully updated.' }
        format.json { render :show, status: :ok, location: @list_item }
      else
        format.html { render :edit }
        format.json { render json: @list_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /list_items/1
  # DELETE /list_items/1.json
  def destroy
   # @list=List.find(params[:list_id])
    @list_item=@list.list_items.find(params[:list_id])
    @list_item.destroy
    respond_to do |format|
      format.html { redirect_to list_url, notice: 'List item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list_item
      @list_item = ListItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_item_params
      params.require(:list_item).permit(:item_name, :quantity, :list_id)
    end

  def find_list
    @list=List.find(params[:list_id])

  end
end
