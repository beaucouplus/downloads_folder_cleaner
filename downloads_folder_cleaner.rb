require 'fileutils'
require "mimemagic"
require 'mimemagic/overlay'
require "pp"
require_relative 'sorting_rules'
require_relative 'list_files'
require_relative 'file_sorter'


pp ListFiles.new.count_extensions
pp ListFiles.new.sort_by_type
