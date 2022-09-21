class ToysController < ApplicationController
  wrap_parameters format: []

rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable

  def index
    toys = Toy.all
    render json: toys
  end

  def create
    toy = Toy.create!(toy_params)
    render json: toy, status: :created
  end

  def update
    toy = Toy.find_by(id: params[:id])
    toy.update(toy_params)
    render json: toy, status: 202
  end

  def destroy
    toy = Toy.find_by(id: params[:id])
    toy.destroy
    head :no_content
  end

  private
  
  def toy_params
    params.permit(:name, :image, :likes)
  end

  def render_not_found
    render json: {error: 'Toy not found'}, status: :not_found
  end

  def render_unprocessable(invalid)
    render json: {errors: invalid.record.errors}, status: :unprocessable_entity
  end

end
