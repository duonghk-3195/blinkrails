class User < ApplicationRecord
    attr_accessor :remember_token
    has_many :post

    before_save :downcase_email

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :name, presence: true, length: { minium: 5, maximum: 50}
    validates :password, presence: true, length: { minimum: 6 }, 
        if: :password # chi thay doi password khi co su thay doi
    has_secure_password # ho tro viec xu ly mat khau
    validates :email, presence: true, length: { minium: 20, maximum: 255, }, 
        format: {with: VALID_EMAIL_REGEX}, # check dinh dang email
        uniqueness: {case_sensitive: false} # thuoc tinh email la duy nhat, khi them opstion scope: :group_id thi co the check unique theo từng group
    
    class << self
        def digest string
            cost = if ActiveModel::SecurePassword.min_cost
                BCrypt::Engine::MIN_COST
            else
                BCrypt::Engine.cost
            end
            BCrypt::Password.create(string, cost: cost)
        end

        def new_token
            SecureRandom.urlsafe_base64
        end
    end

    def remember 
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    def authenticated? remember_token
        return false unless remember_token

        BCrypt::Password.new(remember_digest).is_password? remember_token
    end

    private

    def downcase_email
        self.email = email.downcase
    end
end
