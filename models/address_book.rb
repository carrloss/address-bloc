require_relative 'entry'
require "csv"

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)

    index = 0
    entries.each do |entry|

      if name < entry.name
        break
      end
      index += 1
    end

    entries.insert(index, Entry.new(name, phone_number, email))
  end

  def import_from_csv(file_name)
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)

    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
  end


  # Search AddressBook for a specific entry by name
  def binary_search(name)

    lower = 0 # index of the leftmost item
    upper = entries.length - 1 # index of rightmost item

    while lower <= upper
    # we loop while our lower index
    # is less than or equal to our upper index.
      mid = (lower + upper) / 2
      # middle index by taking the sum
      # of lower and upper and dividing it by two
      mid_name = entries[mid].name

      if name == mid_name
        return entries[mid] # we've found a match
      elsif name < mid_name
        upper = mid - 1 # mid-1 becomes the new upper
      elsif name > mid_name
        lower = mid + 1 # mid+1 becomes the new lower
      end
    end


    return nil # if no match is found
  end

  # Assignment work
  def iterative_search(name)
    entries.each do |entry|
      if entry.name == name
        return entry
      else nil
      end
    end
  end

end
