require 'spec_helper'
require "shared_context/factory"

RSpec.describe FactoryBotFactory::BaseFactory do
  let(:factory) { described_class.new(factory_name: 'test', file_path: file_path) }
  let(:file_path) { 'spec/factories/test.rb' }
  let(:output_path) { 'spec/factories/test.rb' }

  after do
    File.delete(File.open(output_path))
  end

  describe '#write_to_file' do
    context "when file_exists" do
      before do
        File.open(output_path, 'w') {|f| f.write(File.read('./spec/fixtures/factory_template.rb')) }
      end

      it "should raise error" do
        expect { factory.send(:write_to_file, '') }.to raise_exception(FactoryBotFactory::FileExistsError)
      end
    end

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
        factory.send(:write_to_file, '')
        expect(File.file?('spec/factories/test.rb')).to eq(true)
      end
    end
  end
end
