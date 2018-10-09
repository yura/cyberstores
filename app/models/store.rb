class Store < ApplicationRecord
  has_many :domains

  def self.current_store(request)
    if RESERVED_DOMAINS.include?(request.domain)
      find_by(subdomain: request.subdomain) || default
    else
      includes(:domains).find_by(domains: { name: request.host })
    end
  end

  def self.default
    where(default: true, name: DEFAULT_STORE_NAME, subdomain: '')
      .first_or_create
  end
end
