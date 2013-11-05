FactoryGirl.define do
  factory :item do
    name "Test Project"
    base_dir "/test/code"
    description "This is a description"
    has_code true
    slug "test"
  end
  factory :directory_entry do
    full_path "/test/code"
    item
    initialize_with { new(item, full_path, FakeChildGenerator.new) }
  end
end
