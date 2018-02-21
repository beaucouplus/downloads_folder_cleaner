class Path

  attr_reader :folder_name

  def initialize(folder_name)
    @folder_name = folder_name
  end

  def get
    Dir.home.to_s + "/" + folder_name.to_s
  end

end
