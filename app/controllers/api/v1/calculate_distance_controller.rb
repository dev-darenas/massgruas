module Api
  module V1
    class Api::V1::CalculateDistanceController < ApplicationController
      def distance
        lat = (params[:lat]).to_f
        lng = (params[:lng]).to_f
        latb = (params[:lat2]).to_f
        lngb = (params[:lng2]).to_f
        km = Geocoder::Calculations.distance_between([lat, lng], [latb, lngb])
        km = km.round(2)

        render json: {lat: lat, lng: lng, lat2: latb, lng2: lngb, distance_km: km}
      end
    end
  end
end
