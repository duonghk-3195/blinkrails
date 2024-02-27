module API
  class Base < Grape::API
    prefix 'api'
    error_formatter :json, API::ErrorFormatter
    mount API::V1::Base
    # mount API::V2::Root (next version)
  end
end
