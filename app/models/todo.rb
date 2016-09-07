class Todo < ApplicationRecord
  belongs_to :user
  scope :ordered, -> { order("is_finished, created_at desc")}
end
