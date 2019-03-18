class Textlog < ApplicationRecord
  #validates :phone, phone: { possible: true, allow_blank: false, types: [:mobile] }
  validates :name, presence: true
  validates :phone, presence: true
  validates :message, presence: true
end
