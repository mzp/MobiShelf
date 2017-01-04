# frozen_string_literal: true

RSpec.describe Magazine, type: :model do
  describe '#pages' do
    subject do
      described_class.create.tap do |magazine|
        magazine.pages << build(:page, no: 3)
        magazine.pages << build(:page, no: 1)
        magazine.pages << build(:page, no: 2)
      end
    end

    it { expect(subject).to be_persisted }
    it { expect(subject.pages.map(&:no)).to eq([1, 2, 3]) }
  end
end
