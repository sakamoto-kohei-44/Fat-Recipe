class Recipe < ApplicationRecord
  belongs_to :user

  def self.search(keywords)
    keywords = [keywords].flatten
    sql = "title LIKE :keyword0"
    keywords.each_with_index do |_keyword, i|
      sql += " OR title LIKE :keyword#{i + 1}" if i.positive?
    end
    where(sql, keywords.map.with_index.to_h { |keyword, i| ["keyword#{i}", "%#{keyword}%"] }.symbolize_keys)
  end
end
