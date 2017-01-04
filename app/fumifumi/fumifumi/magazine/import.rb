# frozen_string_literal: true
module Fumifumi
  module Magazine
    class Import
      def initialize(path)
        @path = Pathname(path)
      end

      def call
        ApplicationRecord.transaction do
          ::Magazine.create!(title: book.title).tap do |magazine|
            each_content do |content|
              Tempfile.create(encoding: Encoding::ASCII_8BIT) do |temp|
                temp.write content
                magazine.pages.create content: temp
              end
            end
          end
        end
      end

      private

      attr_reader :path

      def book
        @book ||= GEPUB::Book.parse(path)
      end

      def items
        @items ||= book.manifest.item_list
      end

      def pages
        @pages ||= book.spine.itemref_list.map { |ref| ref['idref'] }
      end

      # extract image from page
      def extract(text)
        html = Nokogiri::HTML(text)

        html.css('image').first&.[]('xlink:href') ||
          html.css('img').first&.[]('src')
      end

      def find(href)
        items.values.find { |item| item.href == href }
      end

      def each_content
        pages.each do |page|
          item = items[page]
          href = extract(item.content)

          content = find(href)&.content

          yield content if content
        end
      end
    end
  end
end
