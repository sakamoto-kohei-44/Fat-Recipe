class Recipe < ApplicationRecord
  belongs_to :user

  def self.search(keywords)
    sql = "name LIKE :keyword OR ingredients LIKE :keyword"
    keywords.each_with_index do |_keyword, i|
      sql += " OR name LIKE :keyword#{i + 1} OR ingredients LIKE :keyword#{i + 1}" if i.positive?
    end
    where(sql, keywords: keywords)
  end
end
