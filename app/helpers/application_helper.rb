# frozen_string_literal: true

# Application-wide helper methods
module ApplicationHelper
  def current_store
    Store.current_store(request)
  end
end
