class AllergyItem < ApplicationRecord
  has_many :user_allergies, dependent: :destroy
  has_many :users, through: :user_allergies
end
