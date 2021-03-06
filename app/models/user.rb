class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers=> [:facebook]

  validates :username, presence: true, uniqueness: true, length: {in: 3..12 }
  validate :validate_username_regex

  has_many :posts

  def self.from_omniauth(auth)
    where(provider: auth[:provider], uid:auth[:uid]).first_or_create do |user|
      if auth[:info]
        user.email = auth[:info][:email]
        user.name = auth[:info][:name]
        user.username = auth[:info][:username]
      end
      user.password = Devise.friendly_token[0,20]
    end
  end

  private
    def validate_username_regex
      unless username =~ /\A[a-zA-Z]*[a-zA-Z][a-zA-Z0-9_]*\z/
        errors.add(:username,"El username debe iniciar con una letra")
        errors.add(:username,"El username sólo puede contener _,letras y números")
      end
    end

end
