class List < ActiveRecord::Base
  has_many :list_items, -> { order('position ASC') }, dependent: :destroy
end
