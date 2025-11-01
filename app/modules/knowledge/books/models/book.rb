module Knowledge
  module Books
    module Models
      class Book < ApplicationRecord
        self.table_name = "books"

        validates :title, presence: true
        validates :author, presence: true
      end
    end
  end
end
