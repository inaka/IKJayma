module IKJayma

  class EmptyBodyException < StandardError; end

  class Contacts < Grape::API

    rescue_from EmptyBodyException do |_e|
      Rack::Response.new([""], 204, "Content-Type" => "application/json")
    end

    resource :contacts do

      post do
        params[:id] = "1"
        params.delete(:route_info)
        params
      end

      get do
        [{id: "1", name: "Pedro"}, {id: "2", name: "Pablo"}]
      end

      route_param :id do
        put do
          params.delete(:route_info)
          params
        end

        get do
          {id: params[:id], name: "Pedro"}
        end

        delete do
          raise EmptyBodyException
        end
      end
    end
  end

end
