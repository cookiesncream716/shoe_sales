class Shoe < ActiveRecord::Base
  belongs_to :user
  has_one :sale
end
