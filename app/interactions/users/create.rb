# frozen_string_literal: true

module Users
  class Create < ActiveInteraction::Base
    EMAIL_REGEX = /\A[^@\s]+@(?:[-a-z0-9]+\.)+[a-z]{2,}\z/i
    GENDERS = %w[male female].freeze

    string :name, :surname, :patronymic, :full_name, :email, :nationality, :country, :gender
    integer :age
    array(:interests) { string }
    array(:skills) { string }

    validates :name, :surname, :patronymic, :full_name, :email, :nationality, :country, :age, :gender, presence: true
    validates :email, format: EMAIL_REGEX
    validates :age, numericality: { in: 0..90 }
    validate :valid_gender?
    validate :user_exists?
    validate :valid_gender?

    def execute
      user_attributes = inputs.to_h.except(:interests, :skills)

      ActiveRecord::Base.transaction do
        User.create!(user_attributes).tap do |user|
          interests.each { |interest_name| user.interests.create!(name: interest_name) }
          skills.each { |skill_name| user.skills.create!(name: skill_name) }
        end
      end
    end

    private

    def user_exists?
      errors.add(:email, "User already exists, email: #{email}") if User.where(email:).exists?
    end

    def valid_gender?
      errors.add(:gender, 'Wrong gender.') if GENDERS.none?(gender)
    end
  end
end
