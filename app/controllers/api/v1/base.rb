module API
    module V1
        class Base < Grape::API
            # mount Posts
            mount API::V1::Users
            mount Auth
        end
    end
end