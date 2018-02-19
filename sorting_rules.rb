require 'Psych'

class SortingRules

  CONFIG_FILE = File.expand_path("sort_config.yml").freeze

  def initialize
  end

  def self.all
    Psych.load_file CONFIG_FILE
  end

  def self.find(extension)
    self.all.find { |key,values| values.include?(extension) }
  end


  def set_to_default
    File.open(CONFIG_FILE, "w") {|out| out.puts default.to_yaml }
  end

  private
  def default
    {
      media: ["image","video","audio"],
      archives: [".zip",".pkg",".gz",".bz2",".dmg",".app"],
      code: [".rb",".php",".html",".py",".xml",".js"],
      work: [".pptx",".ppt",".doc",".docx",".xls",".xlsx",".csv",".txt"],
      read: [".pdf",".mobi",".epub"]
    }
  end

end
