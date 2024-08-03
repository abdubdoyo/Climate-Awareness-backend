class CarbonFootprintsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :update, :destroy]
    def index
        @carbon_footprints = CarbonFootprint.all
        render json: @carbon_footprints
      end

      def show
        @carbon_footprint = CarbonFootprint.find(params[:id])
        render json: @carbon_footprint
      end

      def create

        @carbon_footprint = current_user.carbon_footprints.build(carbon_footprint_params)
        if @carbon_footprint.save
          render json: @carbon_footprint, status: :created
        else
          render json: @carbon_footprint.errors, status: :unprocessable_entity
        end
      end

      def update
        @carbon_footprint = CarbonFootprint.find(params[:id])
        if @carbon_footprint.update(carbon_footprint_params)
          render json: @carbon_footprint
        else
          render json: @carbon_footprint.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @carbon_footprint = CarbonFootprint.find(params[:id])
        @carbon_footprint.destroy
        head :no_content
      end

      private

      def carbon_footprint_params
        params.require(:carbon_footprint).permit(:user_id, :transport, :energy, :waste, :total)
      end
end
