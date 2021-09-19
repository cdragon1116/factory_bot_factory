require 'spec_helper'

RSpec.describe FactoryBotFactory::LineWriter do
  let(:writer) { described_class.new(options) }
  let(:options) { {} }

  describe "#build" do
    it "should build line" do
      expect(writer.build("key", "string")).to eq(["key { \"string\" }"])
    end

    context "when configure custom converter" do
      before do
        FactoryBotFactory.configure do |config|
          config.string_converter = Proc.new { |s| "'helloooo'" }
        end
      end

      it "should build line" do
        expect(writer.build("key", "string")).to eq(["key { 'helloooo' }"])
      end
    end
  end
end
