class Boardssong < ApplicationRecord
  belongs_to :board
  belongs_to :song
end
