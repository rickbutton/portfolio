require 'spec_helper'

describe DirectoryEntry do

  subject(:item) { create(:item) }
  subject(:dir) { DirectoryEntry.new(item, item.base_dir, FakeChildGenerator.new) }

  describe '#find' do
    it 'does find sub folders' do
      expect(dir.find('dir1')).not_to be_nil
      expect(dir.find('dir1').name).to eq("dir1")
    end
    it 'does find sub files' do
      expect(dir.find('f1')).not_to be_nil
      expect(dir.find('f1').name).to eq('f1')
    end
    it 'does find sub files recursively' do
      expect(dir.find('dir1/sf1')).not_to be_nil
      expect(dir.find('dir1/sf1').name).to eq('sf1')
    end
    it 'does find sub folders recursively' do
      expect(dir.find('dir1/sd1')).not_to be_nil
      expect(dir.find('dir1/sd1').name).to eq('sd1')
    end
  end
  describe '#type' do
    it 'is a directory' do
      expect(DirectoryEntry.new(item, item.base_dir, 
                                FakeChildGenerator.new).type).to eq(:directory)
    end
  end
  describe '#url' do
    it 'is the directory path' do
      item.stub(:root_dir) { dir }
      expect(DirectoryEntry.new(item, File.join(item.base_dir, 'sub'), 
                              FakeChildGenerator.new).url).to eq("/items/#{item.to_param}/sub")
    end
  end
  %w(attributes as_json).each do |desc|
    describe desc do
      [:type, :name, :full_path, :url, :children].each do |key|
        it "does have key :#{key}" do
          item.stub(:root_dir) { dir }
          expect(dir.send(desc).has_key?(key)).to be_true
        end
      end
    end
  end
end
