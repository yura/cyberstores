# frozen_string_literal: true

# Product model
class Product < ApplicationRecord
  validates :name, presence: true
end
