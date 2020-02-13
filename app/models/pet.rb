class Pet < ApplicationRecord
  validates_presence_of :name,
                        :age,
                        :sex,
                        :shelter_id,
                        :status,
                        :pending_for,
                        :description,
                        :image
  validates :image, format: URI::regexp(%w[http https])
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications
  attribute :status, :string, default: 'adoptable'

  def pending_for_name
    app = Application.find(pending_for)
    app.name
  end

  def pending_for_id
    app = Application.find(pending_for)
    app.id
  end

end
