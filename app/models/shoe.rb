class Shoe < ActiveRecord::Base
  belongs_to :user
  has_many :purchases
  has_many :sales
end
