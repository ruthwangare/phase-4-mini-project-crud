class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
      spices = Spice.all
      render json: spices
    end

    def create
      spice = Spice.new(spice_params)
      if spice.save
        render json: spice, status: :created
      else
        render json: { errors: spice.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      spice = find_spice
      if spice.update(spice_params)
        render json: spice
      else
        render json: { errors: spice.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      spice = find_spice
      spice.destroy
      head :no_content
    end

    private

    def spice_params
      params.permit(:title, :image, :description, :notes, :rating)
    end

    private

    def render_not_found_response
      render json: { error: "Spice not found" }, status: :not_found
    end

    private

    def find_spice
      Spice.find(params[:id])
    end
  end
