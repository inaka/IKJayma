module IKJayma
  class API < Grape::API
    prefix 'api'
    format :json
    mount ::IKJayma::Status
    mount ::IKJayma::Contacts
  end
end
