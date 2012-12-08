class XMWrapper

	require 'open-uri'

	BASE_URL = "https://www.siriusxm.com"
	TIMESTAMP_URL = "/metadata/pdt/en-us/xml/events/timestamp/"
	HEADER_HASH = {
		"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:2.0.1) Gecko/20100101 Firefox/4.0.1"
	}

	
	def self.get_timestamp(time = Time.now)
		puts "Getting Sirius XM timestamp..."
		url = get_timestamp_url(time)
		timestamp_data = Nokogiri::HTML(open(url, HEADER_HASH))
		timestamp_data.css('metadata')
	end

	
	private

	def self.get_timestamp_url(time)
		BASE_URL + TIMESTAMP_URL + convert_time_for_url(time)
	end

	def self.convert_time_for_url(time)
		# the timestamp needs an offset, for some reason
		(time + (60 * 60 * 4) - 10).strftime("%m-%d-%H:%M:%S")	
	end

end