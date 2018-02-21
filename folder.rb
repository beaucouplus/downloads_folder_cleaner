class Folder

  attr_reader :folder

  def initialize(folder = Path.new("Downloads").get)
    @folder = folder.to_s
  end

  def create
    FileUtils.mkdir folder unless Dir.exist?(current(folder))
  end

  def sort
    change_dir
    entries.each_with_object({}) { |(file,v),sorted_files| SortFile.new(sorted_files,file).perform }
  end

  def count_extensions
    entries.each_with_object({}) do |(file,v),hash_|
      extension = File.extname(file).downcase
      sum_files(extension,hash_) unless extension.empty?
    end
  end

  def entries
    Dir.entries(folder)
  end

  def delete_empty_children
    subfolders.each do |folder|
      current_dir = current(folder)
      FileUtils.remove_dir(current_dir) if empty?(current_dir)
    end
  end

  def subfolders
    entries.each_with_object([]) do |file,array|
      next unless Category.new(file).folder?
      array << file
    end
  end


  private

  def current(folder)
    Dir.pwd + "/" + folder
  end

  def empty?(current_dir)
    Dir.entries(current_dir) == [".", "..", ".DS_Store"] || Dir.empty?(current_dir)
  end

  def change_dir
    Dir.chdir(folder)
  end

  def sum_files(type,list)
    entries[type] ||= 0
    entries[type] += 1
  end

end
