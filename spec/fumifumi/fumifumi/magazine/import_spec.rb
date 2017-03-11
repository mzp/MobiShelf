# frozen_string_literal: true

RSpec.describe Fumifumi::Magazine::Import do
  subject { Fumifumi::Magazine::Import.new(magazine).call }

  describe '#import' do
    let(:magazine) { create(:wip_magazine) }
    it do
      expect { subject }.to change(::Page, :count).by(5)

      expect(subject.title).to eq('聖☆おにいさん')
      expect(subject.pages.size).to eq(5)
      expect(subject.pages.map(&:no)).to eq((0..4).to_a)

      expect(subject.episodes.size).to eq(4)
      expect(subject.episodes.map(&:page)).to contain_exactly(
        *subject.pages[1..4].to_a
      )
      expect(subject.finished_at).to be_present
    end

    context 'import again' do
      subject { magazine.reload }
      it do
        3.times { Fumifumi::Magazine::Import.new(magazine).call }
        expect(subject.pages.size).to eq(5)
      end
    end

    describe 'amakan' do
      before do
        magazine.update original_filename: '僕だけがいない街 (1) (カドカワコミックス・エース)_xxx.epub'
      end

      context 'create' do
        it do
          expect { subject }.to change(Series, :count).by(1)
          expect(magazine.reload.series.title).to eq('僕だけがいない街')
        end
      end

      context 'update' do
        before do
          Series.create(title: '僕だけがいない街')
        end

        it do
          expect { subject }.to_not change(Series, :count)
          expect(magazine.reload.series.title).to eq('僕だけがいない街')
        end
      end
    end
  end

  xcontext 'real epub' do
    let(:magazine) { create(:magazine, source: Rails.root.join('sample.epub').open) }
    it { expect(subject.pages).to_not be_empty }
  end
end
