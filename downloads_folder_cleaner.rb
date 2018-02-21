require 'fileutils'
require "mimemagic"
require 'mimemagic/overlay'
require "pp"
require_relative 'category'
require_relative 'folder'
require_relative 'move_files'
require_relative 'path'
require_relative 'sort_file'
require_relative 'sorting_rules'

MoveFiles.new.perform
Folder.new.delete_empty_children
