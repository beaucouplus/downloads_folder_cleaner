class MoveFiles

  attr_accessor :sorted_files

  def initialize(sorted_files = Folder.new.sort)
    @sorted_files = sorted_files
  end

  def perform
    create_folders
    # move_files
  end

  def delete_empty_folders
    Folder.new.subfolders do |folder|
      Folder.new(folder).delete
    end
  end

  private

  def create_folders
    sorted_files.keys.each do |folder|
      next if folder == :folder || folder == :hidden
      Folder.new(folder).create
    end
  end

  def move_files
    sorted_files.each do |folder,files|
      next if folder == :folder || folder == :hidden
      dest_folder = Dir.pwd + "/" + folder.to_s
      files.each { |file| FileUtils.move(file,dest_folder) }
    end
  end
end
