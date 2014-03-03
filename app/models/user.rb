class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :create_remember_token

	has_many :user_practicas, -> { order("position") }, dependent: :destroy
	has_many :user_objetivos, -> { order("position") }, dependent: :destroy
  belongs_to :ambito_trabajo
  belongs_to :sector_empresa

	validates :name, presence: true, length: { maximum: 50 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
	uniqueness: { case_sensitive: false }

  validates_presence_of :country, :ambito_trabajo_id, :sector_empresa_id

	has_secure_password
	validates :password, length: { minimum: 6 }

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def clone_practicas
		all_practicas = Practica.all

		all_practicas.each do |practica|
			self.user_practicas.build(practica_id: practica.id, name: practica.name,
				agile_method: practica.agile_method, 
				position: practica.position, 
				legacy_position: practica.position,
				effort: practica.effort,
				range: -1).save
		end
	end

	def clone_objetivos
		all_objetivos = Objetivo.all

		index = 1
		all_objetivos.each do |objetivo|
			self.user_objetivos.build(
				objetivo_id: objetivo.id, 
				position: index
				).save
			index += 1
		end
	end

	def send_password_reset
	  generate_token(:password_reset_token)
	  self.password_reset_sent_at = Time.zone.now
	  save!(validate: false)
	  UserMailer.password_reset(self).deliver
	end

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end

		def generate_token(column)
    	begin
      	self[column] = SecureRandom.urlsafe_base64
    	end while User.exists?(column => self[column])
  	end
end
