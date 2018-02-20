class SortFile

  attr_reader :file
  attr_accessor :sorted_files

  def initialize(sorted_files, file)
    @sorted_files = sorted_files
    @file = file
  end

  def perform
    category = Category.new(file).find
    sort_file_in(category)
  end

  private

  def sort_file_in(category)
    sorted_files[category.to_sym] ||= []
    sorted_files[category.to_sym] << file
  end

end
