module Api
  module V1
    class Api::V1::CalculateDistanceController < ApplicationController
      def distance
        lat = (params[:lat]).to_f
        lng = (params[:lng]).to_f
        latb = (params[:latb]).to_f
        lngb = (params[:lngb]).to_f
        km = Geocoder::Calculations.distance_between([lat, lng], [latb, lngb])

        render json: {distance_km: km}
      end
    end
  end
end
