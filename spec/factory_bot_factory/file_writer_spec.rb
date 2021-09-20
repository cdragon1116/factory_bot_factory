require 'spec_helper'

RSpec.describe FactoryBotFactory::FileWriter do
  let(:output_path) { 'spec/factories/file_writer_test.rb' }
  let(:output) do
    [
      "factory :new_class, class: Post do",
      "  id { 1 }",
      "  title { \"my first post\" }",
      "  created_at { \"2021-09-20 01:32:27 UTC\" }",
      "  updated_at { \"2021-09-20 01:32:27 UTC\" }",
      "end"
    ]
  end

  after do
    File.delete(File.open(output_path))
  end

  describe '#write' do
    context "when file_exists" do
      before do
        File.open(output_path, 'w') {|f| f.write(File.read('./spec/fixtures/factory_template.rb')) }
        described_class.new(output_path).write(output)
        FactoryBot.reload
      end

      it "should registere new factory" do
        expect(FactoryBot.factories.registered?(:some_factory)).to eq(true)
        expect(FactoryBot.factories.registered?(:new_class)).to eq(true)
      end
    end
  end
end
