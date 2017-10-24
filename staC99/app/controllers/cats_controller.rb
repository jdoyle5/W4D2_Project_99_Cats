class CatsController < ApplicationController
  def index
    @cats = Cat.all

    render :index
  end

  def show
    @cat = Cat.find_by(id: params[:id])

    if @cat
      render :show
    else
      redirect_to cats_url
    end
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)

    if @cat.save
      redirect_to cat_url(@cat)
    else
      render json: @cat.errors.full_messages, status: :unprocessable_entity
    end
  end

  def edit
    @cat = Cat.find_by(id: params[:id])

    if @cat
      render :edit
    else
      redirect_to cats_url
    end
  end

  def update
    @cat = Cat.find_by(id: params[:id])

   if @cat.update_attributes(cat_params)
     redirect_to cat_url(@cat)
   else
     render json: @cat.errors.full_messages, status: :unprocessable_entity
   end
  end

  def destroy
    @cat = Cat.find_by(id: params[:id])

    if @cat
      @cat.destroy
      render :show
    else
      render json: "Cat not found."
    end
  end

  private
  def cat_params
    params.require(:cat).permit(:birth_date, :color, :name, :sex, :description)
  end
end
