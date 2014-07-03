class ApiLogger < Grape::Middleware::Base
  
  def before
    p "[api] Requested: #{request_log_data.to_s}\n" +
     "[api] #{response_log_data[:description]} #{response_log_data[:source_file]}:#{response_log_data[:source_line]}"
  end
  
private
 
  def request_log_data
    request_data = {
      method: env['REQUEST_METHOD'],
      path:   env['PATH_INFO'],
      query:  env['QUERY_STRING']
    }
    request_data
  end
 
  def response_log_data
    {
      description: env['api.endpoint'].options[:route_options][:description],
      source_line: env['api.endpoint'].block.source_location[1]
    }
  end
 
end