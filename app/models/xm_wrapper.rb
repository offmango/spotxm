class XMWrapper

	require 'open-uri'

	BASE_URL = "https://www.siriusxm.com"
	TIMESTAMP_URL = "/metadata/pdt/en-us/xml/events/timestamp/"

	
	def self.get_timestamp(time = Time.now)
		puts "Getting Sirius XM timestamp..."
		url = get_timestamp_url(time)
		timestamp_data = Nokogiri::HTML(open(url))
		timestamp_data.css('metadata')
	end

	
	private

	def self.get_timestamp_url(time)
		BASE_URL + TIMESTAMP_URL + convert_time_for_url(time)
	end

	def self.convert_time_for_url(time)
		# the timestamp needs an offset, for some reason
		(time + (60 * 60 * 4) - 60).strftime("%m-%d-%H:%M:%S")	
	end

end