# frozen_string_literal: true

class Link < ApplicationRecord
  with_options presence: true, uniqueness: { case_sensitive: false } do
    validates :original_url
    validates :code
  end

  before_validation :fill_code, :sanitize_original_url

  private

  def fill_code
    return if original_url.blank?

    previous_seed = Kernel.srand(original_url.hash)
    self.code ||= SecureRandom.alphanumeric(8)
    Kernel.srand(previous_seed)
  end

  def sanitize_original_url
    self.original_url = original_url&.downcase
  end
end
