class User < ApplicationRecord
  has_one :wallet, as: :walletable
  has_many :stocks
  belongs_to :team, optional: true
  validates :username, presence: true, length: { minimum: 6 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  def generate_access_token
    self.access_token = SecureRandom.hex(32)
    self.access_token_expired_date = Time.now + 1.day
    self.save
  end

  def self.find_active_user(access_token: nil)
    return nil unless access_token.present?

    user = User.find_by(access_token: access_token)

    return nil unless user.present?
  
    user.remove_access_token if user.access_token_expired_date < Time.now

    user.access_token.present? ? user : nil
  end

  def remove_access_token
    self.access_token = nil
    self.access_token_expired_date = nil
    self.save
  end
end
