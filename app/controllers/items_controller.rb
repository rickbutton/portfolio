class ItemsController < ApplicationController

  before_action :get_item, except: [:index]
  before_action :get_node, only: [:path, :content]
  before_action :json_default, except: [:index, :show]

  def index
    @items = Item.order(:order)
    respond_to do |format|
      format.html
      format.json { render json: @items }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @item.root_dir, serializer: DirectoryEntrySerializer }
    end
  end

  def path
    unless @node.type == :directory
      raise ActionController::RoutingError.new("Not Found")
    end
    respond_to do |format|
      format.json { render json: @node, serializer: DirectoryEntrySerializer } 
    end
  end

  def content
    unless @node.type == :file
      raise ActionController::RoutingError.new("Not Found")
    end

    respond_to do |format|
      format.json { render json: @node, serializer: FileEntryContentSerializer }
    end
  end

  private

  def json_default
    request.format = "json" unless params[:format]
  end

  def get_item
    @item = Item.where(slug: params[:id]).first
  end

  def get_node
    @node = @item.root_dir.find params[:path]
    raise ActionController::RoutingError.new("Not Found") unless @node
  end

end
