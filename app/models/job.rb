class Job < ApplicationRecord
  # validates :details, presence: true,
  #           length: { minimum: 15 }
  # def self.search(search)
  #   where("title LIKE ? ", "%#{search}%")
  # end
  belongs_to :user ,optional: true
  has_many :requests,dependent: :destroy
  validates :details, presence: true,
            length: { minimum: 5 }

  validates :source_lat, presence: true

  validates :source_long, presence: true

  validates :destination_lat, presence: true

  validates :destination_long, presence: true
end

