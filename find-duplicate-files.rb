require 'digest/md5'

hash = {}

Dir.glob("**/*", File::FNM_DOTMATCH).each do |filename|
  next if File.directory?(filename)
  # puts 'Checking ' + filename

  key = Digest::MD5.hexdigest(IO.read(filename)).to_sym
  if hash.has_key? key
    # puts "same file #{filename}"
    hash[key].push filename
  else
    hash[key] = [filename]
  end
end

hash.each_value do |filename_array|
  if filename_array.length > 1
    puts "=== Identical Files ===\n"
    filename_array.each { |filename| puts '  '+filename }
  end
end
