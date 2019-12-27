class Article < ApplicationRecord
  belongs_to :user
  validates :title, :body , presence: true

  def article_summary
    self.body.length > 30 ? self.body[0,90] + ' . . .' : self.body
  end
end
