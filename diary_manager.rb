require_relative 'entry'
require 'json'
require 'date'

class DiaryManager
  DATA_FILE = 'data.json'

  def initialize
    @entries = load_entries
  end

  def load_entries
    return [] unless File.exist?(DATA_FILE)

    file = File.read(DATA_FILE)
    entries_data = JSON.parse(file)
    entries_data.map { |entry| Entry.new(entry['content'], entry['date']) }
  end

  def save_entries
    entries_data = @entries.map { |entry| { content: entry.content, date: entry.date } }
    File.write(DATA_FILE, JSON.pretty_generate(entries_data))
  end

  def create_entry
    puts "Enter your diary entry (type 'exit' to finish):"
    entry_text = ""

    while (line = gets.chomp) != 'exit'
      entry_text += line + "\n"
    end

    entry = Entry.new(entry_text)
    @entries << entry
    save_entries
    puts "Entry saved!"
  end

  def view_entries
    if @entries.empty?
      puts "No entries found."
    else
      @entries.each_with_index do |entry, index|
        puts "\nEntry ##{index + 1} (#{entry.date}):"
        puts entry.content
      end
    end
  end

  def edit_entry
    view_entries
    puts "Enter the number of the entry you want to edit:"
    entry_number = gets.chomp.to_i - 1

    if entry_number.between?(0, @entries.size - 1)
      puts "Current Entry:"
      puts @entries[entry_number].content
      puts "Enter new content (type 'exit' to finish):"
      new_content = ""

      while (line = gets.chomp) != 'exit'
        new_content += line + "\n"
      end

      @entries[entry_number].content = new_content
      save_entries
      puts "Entry updated!"
    else
      puts "Invalid entry number."
    end
  end

  def delete_entry
    view_entries
    puts "Enter the number of the entry you want to delete:"
    entry_number = gets.chomp.to_i - 1

    if entry_number.between?(0, @entries.size - 1)
      @entries.delete_at(entry_number)
      save_entries
      puts "Entry deleted!"
    else
      puts "Invalid entry number."
    end
  end

  def search_entries
    puts "Enter a keyword to search:"
    keyword = gets.chomp
    found_entries = @entries.select { |entry| entry.content.include?(keyword) }

    if found_entries.empty?
      puts "No entries found with the keyword '#{keyword}'."
    else
      found_entries.each_with_index do |entry, index|
        puts "\nEntry ##{index + 1} (#{entry.date}):"
        puts entry.content
      end
    end
  end
end
