require 'fileutils'
require "mimemagic"
require 'mimemagic/overlay'
require "pp"
require_relative "sorting_rules"


class SortFiles

  DOWNLOADS_FOLDER = "/Users/maximesouillat/Downloads"

  attr_reader :sorting_rules

  def initialize
    # Dir.chdir(DOWNLOADS_FOLDER)
    @files = {}
    @sorting_rules = SortingRules.all
  end

  def list
    Dir.entries(DOWNLOADS_FOLDER)
  end

  def sum_file_extensions
    ext_list = {}
    Dir.foreach(DOWNLOADS_FOLDER) do |file|
      extension = File.extname(file).downcase
      sum_files(extension,ext_list) unless extension.empty?
    end
    ext_list
  end

  def sort_files_by_extension
    Dir.foreach(DOWNLOADS_FOLDER) { |file| sort_files_in_folders(file) }
    @files
  end

  private

  def sum_files(type,list)
    list[type] ||= 0
    list[type] += 1
  end

  def sort_file(sorting_folder,file)
    @files[sorting_folder.to_sym] ||= []
    @files[sorting_folder.to_sym] << file
  end

  def sort_files_in_folders(file)
    extension = File.extname(file).downcase
    return sort_file("folders",file) if File.directory?(file) && extension.empty?
    return sort_file("hidden",file) if file[0] == "."
    return sort_file("archives",file) if extension == ".app"
    sort_with_mime_magic(extension,file)
  end

  def sort_with_mime_magic(extension,file)
    if MimeMagic.by_extension(extension)
      media_type = MimeMagic.by_extension(extension).mediatype
      return sort_file("video",file) if extension == ".srt"
      return sort_file(media_type,file) if find_extension(media_type)
      folder_name = find_extension(extension).first
      return sort_file(folder_name,file) if find_extension(extension)
      sort_file("unknown",file)
    else
      sort_file("unknown",file)
    end
  end

  def find_extension(extension)
    @extensions.find { |key,values| values.include?(extension) }
  end
end



pp SortFiles.new.sorting_rules

pp SortFiles.new.list

# a = MoveFiles.new
# a.move_files
# a.delete_empty_folders
