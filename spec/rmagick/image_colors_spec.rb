require 'spec_helper'

describe Magick::ImageColors do
  let(:image_colors) { Magick::ImageColors.new('spec/fixtures/test.jpg') }

  it 'has a version number' do
    expect(Magick::ImageColors::VERSION).not_to be nil
  end

  describe '#initialize' do
    subject { image_colors }
    before do
      expect_any_instance_of(Magick::ImageColors).to receive(:aggregate)
    end

    it { subject }

    context 'when argment Magick::Image class' do
      let(:image) { Magick::Image.read('spec/fixtures/test.jpg').first }
      let(:image_colors) { Magick::ImageColors.new(image: image) }

      it { subject }
    end
  end

  describe '#colors' do
    subject { image_colors.colors }

    before do
      image_colors.instance_variable_set(:@colors, [])
    end

    it { expect(subject).to eq([]) }
  end

  context 'private method' do
    describe '#aggregate' do
      subject { image_colors.send(:aggregate)[0...3] }

      it { expect(subject.size).to eq(3) }
      it { expect(subject[0]).to eq(['#9AAEC9', 5]) }
      it { expect(subject[1]).to eq(['#FDFDFD', 4]) }
      it { expect(subject[2]).to eq(['#9DAEC8', 4]) }

      context 'when argment block given' do
        subject do
          image_colors.send(:aggregate) do |pixel|
            "#FFFFFF"
          end
        end

        it { expect(subject.size).to eq(1) }
        it { expect(subject[0]).to eq(['#FFFFFF', 2500]) }
      end
    end
  end
end
