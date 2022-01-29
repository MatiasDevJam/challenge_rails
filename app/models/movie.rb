class Movie < ApplicationRecord
  belongs_to :user

  has_many :char_movies, dependent: :destroy
  has_many :characters, through: :char_movies

  validates :image, :title, :rate, presence: true
end
