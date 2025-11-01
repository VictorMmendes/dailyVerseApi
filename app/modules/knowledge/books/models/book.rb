module Knowledge
  module Books
    class Book < ApplicationRecord
      validates :title, presence: true
      validates :author, presence: true
    end
  end
end
