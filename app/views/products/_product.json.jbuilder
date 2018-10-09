# frozen_string_literal: true

json.extract! product, :id, :name, :description, :price
json.url product_url(product, format: :json)
