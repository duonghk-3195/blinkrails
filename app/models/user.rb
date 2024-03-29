class User < ApplicationRecord
    
    attr_accessor :remember_token, :activation_token, :reset_token
    has_many :posts, dependent: :destroy

    has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed

    has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :followers, through: :passive_relationships, source: :follower

    before_save :downcase_email
    before_create :create_activate_digest

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :name, presence: true, length: { minium: 5, maximum: 50}
    validates :password, presence: true, length: { minimum: 6 }, 
        if: :password # chi thay doi password khi co su thay doi
    has_secure_password # ho tro viec xu ly mat khau
    validates :email, presence: true, length: { minium: 20, maximum: 255, }, 
        format: {with: VALID_EMAIL_REGEX}, # check dinh dang email
        uniqueness: {case_sensitive: false} # thuoc tinh email la duy nhat, khi them opstion scope: :group_id thi co the check unique theo từng group

    
    validate :admin_checkbox, on: :update
    def admin_checkbox
        # binding.pry
        is_admin_email = self.email.include? "@sun-asterisk.com"
        if self.is_admin && !is_admin_email
            errors.add :is_admin, "this account can't update to admin"
        end
    end

    def activate
        update_attribute(:activated, true)
        update_attribute(:activated_at, Time.zone.now)
    end

    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end

    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    def feed 
        Post.where(user_id: self.id)
    end

    def follow other_user
        following << other_user
    end

    def unfollow other_user
        following.delete other_user
    end

    def following? other_user
        following.include? other_user
    end
        
    def feed
        # following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
        # Post.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)

        part_of_feed = "relationships.follower_id = :id or posts.user_id = :id"
        Post.joins(user: :followers).where(part_of_feed, {id: id})
    end
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

    def authenticated? attribute, token
        digest = send("#{attribute}_digest")
        return false if digest.nil?

        BCrypt::Password.new(digest).is_password? token
    end

    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end

    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_sent_at, Time.zone.now)
        update_attribute(:reset_digest, User.digest(reset_token))
    end

    private

    def downcase_email
        self.email = email.downcase
    end

    def create_activate_digest
        self.activation_token = User.new_token
        self.activation_digest = User.digest(self.activation_token)
    end

end
