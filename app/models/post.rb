class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 1000,
                                                too_long: '1000 characters in post is the maximum allowed.' }

  belongs_to :user

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def self.visible_posts(current_user)
    puts 'Visible posts calculating'
    friends_ids = current_user.friends
    friends_ids << current_user.id
    Post.all.where(user_id: friends_ids)
  end
end
