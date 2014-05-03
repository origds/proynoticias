class Report < ActiveRecord::Base
  belongs_to :users

  VALID_STRING_REGEX = /\A[\w+\-\ .]*\z/
  validates :title, :presence => true, format: { with: VALID_STRING_REGEX } 
  validates :content, :presence => true, format: { with: VALID_STRING_REGEX } 
  validates :source, format: { with: VALID_STRING_REGEX } 

end
