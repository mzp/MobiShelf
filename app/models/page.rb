# frozen_string_literal: true
class Page < ApplicationRecord
  belongs_to :magazine

  has_attached_file :content
  validates_attachment :content,
                       presence: true,
                       content_type: { content_type: 'image/png' }
end
