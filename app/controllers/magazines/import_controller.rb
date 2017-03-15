# frozen_string_literal: true

module Magazines
  class ImportController < ApplicationController
    def create
      Magazine.update_all finished_at: nil
      Magazine.all.each do |magazine|
        ImportMagazineJob.perform_later magazine
      end
      redirect_to :magazines_dashboard_index
    end

    def update
      magazine = Magazine.find(params[:id])
      magazine.update finished_at: nil
      ImportMagazineJob.perform_later magazine
      redirect_to :magazines_dashboard_index
    end
  end
end
