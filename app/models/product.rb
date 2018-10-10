# frozen_string_literal: true

# Product model
class Product < ApplicationRecord
  belongs_to :store

  validates :name, presence: true
end
