class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wish_list
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = @wish_list.items
    render json: @items
  end

  def show
    render json: @item
  end

  def create
    @item = @wish_list.items.build(item_params)
    if @item.save
      attach_images if params[:item][:images].present?
      render json: @item, status: :created
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      attach_images if params[:item][:images].present?
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    head :no_content
  end

  private

  def set_wish_list
    @wish_list = current_user.wish_lists.find(params[:wish_list_id])
  end

  def set_item
    @item = @wish_list.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :single_booking)
  end

  def attach_images
    params[:item][:images].each do |image|
      @item.images.attach(image)
    end
  end
end
