class MoveFiles

  attr_accessor :sorted_files

  def initialize(sorted_files = Folder.new.sort)
    @sorted_files = sorted_files
  end

  def perform
    create_destination_folders
    move_sorted_files
    pp "Successfully moved files"
  end

  private

  def create_destination_folders
    sorted_files.keys.each do |folder|
      next if excluded_files?(folder)
      Folder.new(folder).create
    end
  end

  def move_sorted_files
    sorted_files.each do |folder,files|
      next if excluded_files?(folder)
      move_files(folder,files)
    end
  end

  def excluded_files?(file)
    file == :folder || file == :hidden
  end

  def move_files(folder,files)
    dest_folder = Dir.pwd + "/" + folder.to_s
    files.each { |file| FileUtils.move(file,dest_folder) }
  end

end
