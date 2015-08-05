class ProxyRule < ActiveRecord::Base
  SFC_GATEWAY_DOMAIN_REGEX = /\.?gw\.sfc/
  VALID_DOMAIN_REGEX = /\A(?:[A-Za-z0-9][A-Za-z0-9\-]{0,61}[A-Za-z0-9]|[A-Za-z0-9])\z/

  belongs_to :user

  validates :name, presence: true
  validates :domain, format: { with: VALID_DOMAIN_REGEX }, uniqueness: true
  validates :url, format: { with: /\Ahttp:/ }
  enum auth_type: { open: 0, intranet: 1, slack_auth: 2 }

  scope :active, -> { where('expired_at IS NULL OR expired_at < ?', Time.now) }
end
