class Category

  attr_reader :extension, :file

  def initialize(file)
    @file = file
    @extension = File.extname(file).downcase
  end

  def find
    return custom_rule if SortingRules.find(extension)
    return :folder if folder?
    return :hidden if file[0] == "."
    return mediatype if has_mime?
    :unknown
  end

  def folder?
    File.directory?(@file) && extension.empty?
  end

  private
  def extension
    File.extname(@file).downcase
  end

  def has_mime?
    MimeMagic.by_extension(extension)
  end

  def mediatype
    MimeMagic.by_extension(extension).mediatype
  end

  def custom_rule
    SortingRules.find(extension).first
  end

end
