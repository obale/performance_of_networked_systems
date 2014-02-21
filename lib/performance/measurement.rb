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

  property :fetches, Integer
  property :max_parallel, Integer
  property :fetches_per_second, Float

  property :endpoint, String

  # Export all entries in the database to a CSV (comma separated values) file.
  def self.to_csv_file(directory = "/tmp/")
    now = Time.now.strftime("%Y-%m-%d_%H_%m")
    remote_hosts = CONFIG['remote_hosts']
    remote_hosts.each do |host|
      type = host.split("/").last.split(".").last
      hostname = host.split("/")[2].split(".").first # TODO: Change to regular expression statement
      puts "type: #{type}"
      puts "hostname: #{hostname}"
      File.open("#{directory}#{CONFIG['hostname']}_to_#{hostname}_#{type}_#{now}.csv", 'w') do |file|
        csv_data = Performance::Measurement.all(:endpoint => host).to_csv.gsub("\n\n", "\n")
        puts csv_data
        file.write("id,created_at,min_msecs,mean_msecs,max_msecs,rate,seconds,fetches,max_parallel,fetches_per_second,endpoint\n")
        file.write(csv_data)
      end
    end
  end
end
