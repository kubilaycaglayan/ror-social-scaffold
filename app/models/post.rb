class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 1000,
                                                too_long: '1000 characters in post is the maximum allowed.' }

  belongs_to :user

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def visible_posts(current_user)
    p friends_ids = current_user.friends
    p friends_ids << current_user.id
    p Post.all.where(user_id: friends_ids).ordered_by_most_recent
  end
end
