module API
    module V1
        class Users < Grape::API
            include Defaults
            version 'v1', using: :path
            format :json

            # before do
            #     authenticate_user!
            # end

            resource :users do
                desc "Return list of recent users"
                get "", root: :users do
                    users = User.all
                    present users, with: API::Entities::User
                end

                desc "Return a user"
                params do
                    requires :id, type: Integer, desc: "ID of the user"
                end
                    get ":id" do
                    user = User.find params[:id]
                    present user, with: API::Entities::User
                end

                desc "Update a user"
                params do
                    requires :user, type: Hash, desc: "User info" do
                        requires :name, type: String, desc: "user name"
                        requires :email, type: String, desc: "email of user"
                        optional :password, type: String, desc: "password account"
                        optional :password_confirmation, type: String, desc: "password confirm account"
                        optional :is_admin, type: Boolean, desc: "role of the user"
                    end
                end
                patch ":id/update" do
                    @user = User.find params[:id]
                    @user.name = params[:user][:name]
                    @user.email = params[:user][:email]
                    if !params[:user][:email].empty?
                        @user.password = params[:user][:password]
                        @user.password_confirmation = params[:user][:password_confirmation]
                    end
                    if @user.save
                        status 201
                        present @user, with: API::Entities::User
                    else
                        @message = "can't update user"
                        status 3000
                        present @message
                    end
                end

            end
        end
    end
end