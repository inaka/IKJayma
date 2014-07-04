module IKJayma
  class App < Goliath::API
    use Goliath::Rack::Params
    use Goliath::Rack::Render

    def response(env)
      IKJayma::API.call(env)
    end
  end
end
