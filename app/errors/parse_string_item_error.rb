# frozen_string_literal: true

module Errors
  # Means the string was an invalid
  # purchase item string
  class ParseStringItemError < StandardError
    def initialize(msg = 'The string cannot be pased as a purchase item')
      super
    end
  end
end
