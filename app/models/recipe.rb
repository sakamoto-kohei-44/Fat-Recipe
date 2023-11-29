class Recipe < ApplicationRecord
  belongs_to :user
  has_many :favorites

  def self.search(keywords)
    sql = "name LIKE :keyword OR ingredients LIKE :keyword"
    keywords.each_with_index do |_keyword, i|
      sql += " OR name LIKE :keyword#{i + 1} OR ingredients LIKE :keyword#{i + 1}" if i > 0
    end
    where(sql, keywords: keywords)
  end
end
