def read_file_to_s(callin_file_name,file_name)
  dir = File.dirname(callin_file_name)
  file = File.open(File.join(dir,file_name))
  return file.read
end

def read_file_to_json(callin_file_name,file_name)
  json_str = read_file_to_s(callin_file_name,file_name)
  return JSON.parse(json_str)
end


