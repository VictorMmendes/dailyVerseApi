module Scriptures
  module Verses
    module Models
        class Verse < ApplicationRecord
          self.table_name = "verses"

          # Add your domain invariants here
          # validates :name, presence: true
        end
    end
  end
end
