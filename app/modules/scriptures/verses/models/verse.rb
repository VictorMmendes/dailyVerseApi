module Scriptures
  module Verses
    module Models
        class Verse < ApplicationRecord
          self.table_name = "verses"

          validates :content, presence: true
          validates :reference, presence: true
        end
    end
  end
end
