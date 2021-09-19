require 'spec_helper'
require "shared_context/factory"

RSpec.describe FactoryBotFactory::BaseFactory do
  let(:factory) { described_class.new(factory_name: 'test', file_path: file_path) }
  let(:file_path) { 'spec/factories/test.rb' }

  before do
    File.open(file_path, 'w') {|f| f.write(File.read('./spec/fixtures/factory_template.rb')) }
  end

  after do
    File.delete(File.open(file_path))
  end

  describe '#write_to_file' do
    it "when file exists" do
      expect { factory.send(:write_to_file, '') }.to raise_exception(FactoryBotFactory::FileExistsError)
    end
  end
end
