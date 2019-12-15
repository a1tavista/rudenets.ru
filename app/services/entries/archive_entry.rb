module Entries
  class ArchiveEntry
    include Dry::Transaction

    map :initialize_records
    step :archive_entry

    def initialize_records(input)
      {
        entry: input[:entry] || Entry.find_by(input[:entry_find_by])
      }
    end

    def archive_entry(input)
      input[:entry].update(published: false, published_at: nil)

      Success(input)
    end
  end
end
