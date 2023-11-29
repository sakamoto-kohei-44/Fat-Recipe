class AllergyItem < ApplicationRecord
  has_many :allergies, dependent: :destroy
end