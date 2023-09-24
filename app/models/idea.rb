class Idea < ApplicationRecord
    validates :title, :amount, :date,  presence: true
end
