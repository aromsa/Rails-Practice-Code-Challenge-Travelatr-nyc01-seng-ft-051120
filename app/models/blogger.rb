class Blogger < ApplicationRecord
  has_many :posts

  validates :name, uniqueness: true
  validates :age, numericality: { greater_than: 0 }
  validates :bio, length: { minimum: 30 } 

end
