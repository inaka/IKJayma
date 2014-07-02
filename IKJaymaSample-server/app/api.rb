module IKJayma
  class API < Grape::API
    prefix 'api'
    format :json
    mount ::IKJayma::Status
  end
end
