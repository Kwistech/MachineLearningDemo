# frozen_string_literal: true

# Loads the log into memory
def load_log(filename)
  logs = []

  File.open(filename, 'r') do |file_handle|
    file_handle.each do |line|
      logs.push(line.split(','))
    end
  end

  logs

end

# Gets the attributes (columns) of the log
def get_attributes(logs)
  logs[0][-1].delete!("\n")
  logs[0]
end

# Gets all the log entries
def get_log_entries(logs)
  logs[1..logs.length]
end

# Converts the first index to an integer (severity)
def string_to_int(logs)
  logs.each do |entry|
    entry[0] = entry[0].to_i
  end
  logs
end
