class Posts < Grape::API
    version 'v1'
    format :json

    resource :posts do
        desc "Return list of recent posts"
        get do
            @post = Post.all
        end
    end
end

