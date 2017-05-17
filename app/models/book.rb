class Book < ApplicationRecord
  belongs_to :user
  default_scope -> { order(updated_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true
  validates :author, presence: true
end
