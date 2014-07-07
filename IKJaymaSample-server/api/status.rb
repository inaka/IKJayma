module IKJayma
  class Status < Grape::API
    format :json
    get '/status' do
      "Working"
    end
  end
end
