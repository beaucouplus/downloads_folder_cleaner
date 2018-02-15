require 'Psych'

class SortingRules

  def initialize
  end

  def self.all
    Psych.load_file sort_config
  end

  def set_to_default
    File.open(sort_config, "w") {|out| out.puts default.to_yaml }
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

  def self.sort_config
    "sort_config.yml"
  end


end
