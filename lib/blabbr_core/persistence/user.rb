# encoding: utf-8
module BlabbrCore
  module Persistence
    class User
      include Mongoid::Document
      include Mongoid::Timestamps::Created
      include Mongoid::Fromage
      include BlabbrCore::Limace
      include ActiveModel::SecurePassword
      has_secure_password

      # Fields
      #
      field :email,           type: String
      field :nickname,        type: String
      field :posts_count,     type: Integer, default: 0
      field :state,           type: Symbol,  default: :inactive
      field :password_digest, type: String

      # Relations
      #
      has_many :topics, class_name: 'BlabbrCore::Persistence::Topic'

      # Validations
      #
      validates :email,    presence: true, uniqueness: true
      validates :nickname, presence: true, uniqueness: true, length: { in: 4..42 }

      # Limace
      #
      limace :nickname

      # Roles
      #
      fromages :admin

      # Scopes
      #
      scope :page, Proc.new {|num| limit(10).offset(10 * ([num.to_i, 1].max - 1))}
    end
  end
end
