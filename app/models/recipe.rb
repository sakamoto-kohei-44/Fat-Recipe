class Recipe < ApplicationRecord
  belongs_to :user

  def self.search(keywords)
    keywords = [keywords].flatten  # # 配列に変換
    query_parts = keywords.map { |keyword| "title LIKE ?" }
    where(query_parts.join(" OR "), *keywords.map { |keyword| "%#{keyword}%" })
  end
end
