class Post < ApplicationRecord
    belongs_to :user
    validates :title, length: { maximum: 250 }
end
