class Invitation < ApplicationRecord
  belongs_to :account

  before_create :generate_token

  validates :email, presence: true
 
  private

  def generate_token
    self.token = SecureRandom.hex(16)
  end

  def to_param
    token
  end
end
