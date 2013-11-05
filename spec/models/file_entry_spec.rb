require 'spec_helper'

describe FileEntry do
  subject(:item) { create(:item) }
  subject(:dir) { DirectoryEntry.new(item, item.base_dir, FakeReplaceChildGenerator.new([])) }
  subject(:f) { FileEntry.new(item, File.join(item.base_dir, 'file'), false) }

  describe '#type' do
    it 'is a file' do
      expect(f.type).to eq(:file)
    end
  end
  describe '#url' do
    it 'is the file content path' do
      item.stub(:root_dir) { dir }
      expect(f.url).to eq("/items/#{item.to_param}/file/content")
    end
  end
  describe '#content' do
    it 'reads the correct local file' do
      File.stub(:read).with(f.full_path) { "test" }
      expect(f.content).to eq("test")
    end
  end
  %w(attributes as_json).each do |desc|
    describe desc do
      [:type, :name, :full_path, :content_url].each do |key|
        it "does have key :#{key}" do
          item.stub(:root_dir) { dir }
          expect(f.send(desc).has_key?(key)).to be_true
        end
      end
    end
  end

end
