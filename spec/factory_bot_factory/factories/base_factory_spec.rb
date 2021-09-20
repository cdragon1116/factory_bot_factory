require 'spec_helper'

RSpec.describe FactoryBotFactory::BaseFactory do
  let(:factory) { described_class.new(factory_name: 'test', file_path: file_path) }
  let(:output_path) { 'spec/factories/test.rb' }

  describe '#write_to_file' do
    context "when factory_path exists" do
      let(:file_path) { nil }

      before do
        FactoryBotFactory.configure do |c|
          c.factory_path = 'spec/factories/'
        end
      end

      after do
        set_to_default
      end

      it "should fallback to use factory path" do
        expect(factory.file_path).to eq(output_path)
      end
    end
  end
end
