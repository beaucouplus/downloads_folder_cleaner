class Downloads

  DOWNLOADS_FOLDER = "/Users/maximesouillat/Downloads"

  def initialize
    Dir.chdir(DOWNLOADS_FOLDER)
    puts Dir.pwd
  end

  def list
    puts Dir.entries(DOWNLOADS_FOLDER)
  end

  def sum_file_extensions
    ext_list = {}
    file_counter = 0

    Dir.foreach(DOWNLOADS_FOLDER) do |file|
      file_counter = file_counter + 1
      extension = File.extname(file)
      ext_list[extension] = file_counter
    end

    p ext_list
  end

end

a = Downloads.new
# a.list
a.sum_file_extensions
