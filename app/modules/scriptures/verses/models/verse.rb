module Scriptures
  module Verses
    class Verse < ApplicationRecord
      validates :content, presence: true
      validates :reference, presence: true
    end
  end
end
