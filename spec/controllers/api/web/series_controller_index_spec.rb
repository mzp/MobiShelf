# frozen_string_literal: true

RSpec.describe Api::Web::SeriesController, type: :controller do
  let!(:series) { create_list(:series, 3) }
  let!(:magazines) { create_list(:magazine, 10, series: series.first) }

  before { get :index }
  subject { response.body }

  describe '#series' do
    it do
      expect(subject).to have_json_size(3)
      0.upto(2) do |i|
        expect(subject).to be_json_eql(series[i].title.to_json).at_path("#{i}/title")
      end
    end
  end

  describe '#magazines' do
    it do
      expect(subject).to have_json_size(5).at_path('0/magazines')
      expect(subject).to be_json_eql(api_web_magazines_path(series_id: series.first.id, page: 2, per_page: 5).to_json)
        .at_path('0/magazines_url')
      expect(subject).to be_json_eql(nil.to_json).at_path('1/magazines_url')
      0.upto(4) do |i|
        expect(subject).to be_json_eql(magazines[-i - 1].title.to_json).at_path("0/magazines/#{i}/title")
        expect(subject).to have_json_path("0/magazines/#{i}/url")
        expect(subject).to have_json_path("0/magazines/#{i}/cover")
        expect(subject).to_not have_json_path("0/magazines/#{i}/episodes")
      end
    end
  end
end
