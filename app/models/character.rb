class Character < ApplicationRecord
  validates :image, :name, :age, :weight, :history, :user_id, presence: true
  belongs_to :user
  has_many :char_movies, dependent: :destroy
  has_many :movies, through: :char_movies

  def self.search(params = {})
    character = params[:character_ids].present? ? Character.where(id:params[:character_ids]) : Character.all
    character = character.filter_by_name(params[:keyword]) if params[:keyword]
    character = character.filter_by_age(params[:age].to_i) if params[:age]

    character
  end


end
