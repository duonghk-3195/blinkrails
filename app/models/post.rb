class Post < ApplicationRecord
    belongs_to :user
    default_scope -> { order(created_at: :desc) }
    validates :title, presence: true, length: { maximum: 250 }
    validates :user_id, presence: true
    validates :content, presence: true, length: { maximum: 1000 }
    has_one_attached :image
    validates :image, content_type: { in: %w[image/jpeg image/gif image/png], message: "must be a valid image format"},
                      size: { less_than: 5.megabytes, message: "should be less than 5MB" }

    delegate :name, to: :user, prefix: true

    def display_image
        image.variant(resize_to_limit: [300, 300]) # hien tai no khong resize duoc anh hien thi. se tim cach fix sau
    end
end
