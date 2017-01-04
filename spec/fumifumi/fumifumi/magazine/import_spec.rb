# frozen_string_literal: true

RSpec.describe Fumifumi::Magazine::Import do
  let(:epub) { file_fixture('saint_oniisan.epub') }

  describe 'count' do
    subject { Fumifumi::Magazine::Import.new(epub).call }

    it { expect { subject }.to change(::Page, :count).by(4) }
    it { expect { subject }.to change(::Magazine, :count).by(1) }
  end

  describe 'imported magazine' do
    subject { Fumifumi::Magazine::Import.new(epub).call }

    it { expect(subject.title).to eq('聖☆おにいさん') }
  end
end
