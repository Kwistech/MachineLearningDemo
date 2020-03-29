# frozen_string_literal: true

# Import statements
require 'decisiontree'
require_relative '../services/io_service'

# Main function
def main

  # Load all log into memory
  logs = load_log('res\security.log')

  # Set title of columns
  attributes = get_attributes(logs)

  # Load security log data
  training_data = get_log_entries(logs)

  # Convert 'severity' from String to int
  training_data = string_to_int(training_data)

  # Instantiate the decision tree, and train it based on the data
  dec_tree = DecisionTree::ID3Tree.new(attributes, training_data, 'Investigate',
                                       category: :discrete,
                                       severity: :continuous)
  # --- DEBUGGING ---
  #
  # puts(attributes)
  # puts(training_data)
  #
  # -----------------

  # Execute the training
  dec_tree.train

  # --- Test the outcome given a test sample ---
  test_entries = [
    [3, 'Successful Login', 'Investigate'],
    [5, 'Successful Login', 'Do Not Investigate'],
    [1, 'Malware', 'Investigate'],
    [5, 'Malware', 'Investigate'],
    [5, 'Failed Login', 'Investigate'],
    [1, 'Exploit', 'Investigate']
  ]

  # Predict the outcome given the training_data and test_entry
  test_entries.each_with_index do |entry, index|
    decision = dec_tree.predict(entry)
    puts "Entry #{index + 1}: #{entry}\nPredict: #{decision} Actual: #{entry.last}\n\n"
  end

  # --------------------------------------------

end

# Call the main method
main
