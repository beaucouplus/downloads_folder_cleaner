class FileSorter

  attr_reader :sorting_rules, :file, :extension
  attr_accessor :categories

  def initialize(categories, file)
    @categories = categories
    @file = file
    @sorting_rules = SortingRules.all
    @extension = File.extname(file).downcase
  end

  def sort
    return add_to_folders if folder?
    return add_to_hidden if hidden?
    return add_to_apps if app?
    return add_to_video if subtitle?
    sort_with_mime_magic
  end

  def sort_with_mime_magic
    return add_to_unknown unless MimeMagic.by_extension(extension)
    return add_to_mediatype if mediatype?
    add_to_custom_category if custom_category?
  end

  private

  def mediatype
    MimeMagic.by_extension(extension).mediatype
  end

  def mediatype?
    true if find_sorting_rule(mediatype)
  end

  def add_to_mediatype
    add_to_category(mediatype)
  end

  def custom_category?
    true if find_sorting_rule(extension)
  end

  def custom_category
    find_sorting_rule(extension).first
  end

  def add_to_custom_category
    add_to_category(custom_category)
  end


  def find_sorting_rule(extension)
    sorting_rules.find { |key,values| values.include?(extension) }
  end

  def folder?
    File.directory?(file) && extension.empty?
  end

  def hidden?
    true if file[0] == "."
  end

  def app?
    true if extension == ".app"
  end

  def subtitle?
    true if extension == ".srt"
  end

  def add_to_folders
    add_to_category("folder")
  end

  def add_to_apps
    add_to_category("app")
  end

  def add_to_hidden
    add_to_category("hidden")
  end

  def add_to_video
    add_to_category("video")
  end

  def add_to_category(category)
    categories[category.to_sym] ||= []
    categories[category.to_sym] << file
  end

  def add_to_unknown
    add_to_category("unknown")
  end

end
