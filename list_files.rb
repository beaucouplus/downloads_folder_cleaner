class ListFiles

  attr_reader :folder

  def initialize(folder = "/Users/maximesouillat/Downloads")
    @folder = folder
    Dir.chdir(folder)
  end

  def sort_by_type
    list.each_with_object({}) { |(file,v),categories| FileSorter.new(categories,file).sort }
  end

  def count_extensions
    list.each_with_object({}) do |(file,v),hash_|
      extension = File.extname(file).downcase
      sum_files(extension,hash_) unless extension.empty?
    end
  end

  private

  def list
    Dir.entries(folder)
  end

  def sum_files(type,list)
    list[type] ||= 0
    list[type] += 1
  end

end
