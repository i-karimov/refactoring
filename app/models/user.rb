class User < ApplicationRecord
  has_many :user_interests
  has_many :interest, through: :user_interests

  has_many :user_skills
  has_many :skills, trough: :user_skills
end
