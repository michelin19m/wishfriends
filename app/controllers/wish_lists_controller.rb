class WishListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wish_list, only: [:show, :edit, :update, :destroy]

  def index
    @wish_lists = current_user.wish_lists
    render json: @wish_lists
  end

  def show
    render json: @wish_list
  end

  def create
    @wish_list = current_user.wish_lists.build(wish_list_params)
    if @wish_list.save
      render json: @wish_list, status: :created
    else
      render json: @wish_list.errors, status: :unprocessable_entity
    end
  end

  def update
    if @wish_list.update(wish_list_params)
      render json: @wish_list
    else
      render json: @wish_list.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @wish_list.destroy
    head :no_content
  end

  private
    def set_wish_list
      @wish_list = current_user.wish_lists.find(params[:id])
    end

    def wish_list_params
      params.require(:wish_list).permit(:name)
    end
end
