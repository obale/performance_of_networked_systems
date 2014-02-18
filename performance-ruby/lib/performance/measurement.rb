require 'dm-serializer/to_csv'

class Performance::Measurement
  include DataMapper::Resource

  property :id, Serial
  property :created_at, DateTime

  property :min_msecs, Float
  property :mean_msecs, Float
  property :max_msecs, Float

  # http_load --rate
  property :rate, Integer
  # http_load --seconds
  property :seconds, Integer

  property :endpoint, String

  # Export all entries in the database to a CSV (comma separated values) file.
  def self.to_csv_file(filename)
    File.open(filename, 'w') do |file|
      file.write(Performance::Measurement.all.to_csv.gsub("\n\n", "\n"))
    end
  end
end
