class Shop < ApplicationRecord
  has_many :items, dependent: :destroy
  validates_presence_of :title, :location, :created_by
end
