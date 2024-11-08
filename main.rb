require_relative 'diary_manager'

def main
  diary_manager = DiaryManager.new

  puts "Welcome to the Personal Diary App!"

  loop do
    puts "\nChoose an option:"
    puts "1. Create a new entry"
    puts "2. View all entries"
    puts "3. Edit an entry"
    puts "4. Delete an entry"
    puts "5. Search entries"
    puts "6. Exit"

    choice = gets.chomp.to_i

    case choice
    when 1
      diary_manager.create_entry
    when 2
      diary_manager.view_entries
    when 3
      diary_manager.edit_entry
    when 4
      diary_manager.delete_entry
    when 5
      diary_manager.search_entries
    when 6
      puts "Goodbye!"
      break
    else
      puts "Invalid option. Please try again."
    end
  end
end

main
