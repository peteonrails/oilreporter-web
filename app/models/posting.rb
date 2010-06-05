class Posting < ActiveRecord::Base
  belongs_to :blog
  belongs_to :post
end