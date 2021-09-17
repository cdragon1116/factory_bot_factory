RSpec.shared_context :factory, :shared_context => :metadata do
  let(:factory_name) { :my_class }
  let(:file_path) { "./spec/factories/#{factory_name}.rb" }
  let(:output) { nil }

  before do
    File.open(file_path, 'w') {|f| f.write(output) }
    FactoryBot.reload
  end

  after do
    File.delete(File.open(file_path))
  end
end
