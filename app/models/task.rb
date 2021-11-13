# == Schema Information
#
# Table name: tasks
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  deadline   :datetime         not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_tasks_on_board_id  (board_id)
#  index_tasks_on_user_id   (user_id)
#
class Task < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { maximum: 10 }

  validates :content, presence: true
  validates :title, length: { maximum: 100 }

  belongs_to :user
  belongs_to :board
  has_many :comments, dependent: :destroy
  has_one_attached :eyecatch
end
