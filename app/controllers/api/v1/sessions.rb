class Sessions < Grape::API
    version 'v1'
    format :json

    resource :login do
        desc "Return login form"
        get do
            
        end
    end
end