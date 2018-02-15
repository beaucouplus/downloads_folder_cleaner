class MoveFiles

  def move_files
    sorted_files = SortFiles.new.sort_files_by_extension
    sorted_files.delete(:hidden)
    sorted_files.delete(:folders)
    create_folders(sorted_files)

    sorted_files.each do |sorting_folder,files|
      dest_folder = Dir.pwd + "/" + sorting_folder.to_s
      files.each { |file| FileUtils.move(file,dest_folder) }
    end
  end

  def delete_empty_folders
    Dir.foreach(Dir.pwd) do |file|
      extension = File.extname(file).downcase
      if File.directory?(file) && extension == ""
        current_dir = Dir.pwd + "/" + file
        FileUtils.remove_dir(current_dir) if Dir.entries(current_dir) == [".", "..", ".DS_Store"]
      end
    end
  end

  private

  def create_folders(sorted_files)
    sorted_files.keys.each do |folder|
      folder = folder.to_s
      download_files = SortFiles.new.sort_files_by_extension
      FileUtils.mkdir folder unless download_files[:folders].include?(folder)
    end
  end

end
