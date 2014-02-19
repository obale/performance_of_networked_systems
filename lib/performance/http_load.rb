class Performance::HttpLoad

  def self.exec
    http_load_exec = File.expand_path('../../bin/http_load', File.dirname(__FILE__))

    hosts = CONFIG['remote_hosts']
    rates = CONFIG['rates']
    seconds = CONFIG['seconds']
    raise "Array of rates and seconds have different length!" unless seconds.length == rates.length

    hosts.each do |host|
      puts "[ENDPOINT] Measuring for '#{host}'. Current date and time: #{Time.now}"
      url_list = self.write_url_list_file(host)
      rates.length.times do |i|
        puts "[PERF] Executing: http_load -rate #{rates[i]} -seconds #{seconds[i]} #{url_list}"
        output = `#{http_load_exec} -rate #{rates[i]} -seconds #{seconds[i]} #{url_list}`
        perfs = output.lines[4].split(" ")
        mean = perfs[1]
        max = perfs[3]
        min = perfs[5]

        Performance::Measurement.create(
          endpoint: host,
          mean_msecs: perfs[1],
          max_msecs: perfs[3],
          min_msecs: perfs[5],
          seconds: seconds[i],
          rate: rates[i]
        )
      end
      puts "-----------------"
    end
  end

  private
  def self.write_url_list_file(host)
    filename = "/tmp/url_list.txt"
    File.open(filename, 'w') do |file|
      file.write(host)
    end
    filename
  end

end

