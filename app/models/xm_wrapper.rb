class XMWrapper

	require 'open-uri'

	BASE_URL = "https://www.siriusxm.com"
	TIMESTAMP_URL = "/metadata/pdt/en-us/xml/events/timestamp/"
	PAD_DATA_URL = "http://www.siriusxm.com/padData/pad_provider.jsp?all_channels=y"
	HEADER_HASH = {
		"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:2.0.1) Gecko/20100101 Firefox/4.0.1" #,
		# "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
		# "Accept-Language" => "en-us,en;q=0.5",
		# "Accept-Encoding" => "gzip, deflate",
		# "Accept-Charset" => "ISO-8859-1,utf-8;q=0.7,*;q=0.7",
		# "Keep-Alive" => "115",
		# "Connection" => "keep-alive",
		# "Cookie" => "sxm_platform=sirius; __utma=92839455.290103813.1308663901.1308663901.1308663901.1; __utmb=92839455.2.10.1308663901; __utmc=92839455; __utmz=92839455.1308663901.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none)"
	}

	
	def self.get_timestamp(time = Time.now)
		puts "Getting Sirius XM timestamp..."
		url = get_timestamp_url(time)
		timestamp_data = Nokogiri::HTML(open(url, HEADER_HASH))
		timestamp_data.css('metadata')
	end

	def self.get_typhoeus_timestamp(time = Time.now)
		puts "Getting timestamp with Typhoeus"
		url = get_timestamp_url(time)
		request = Typhoeus::Request.new(url)
		hydra = Typhoeus::Hydra.new
		hydra.queue(request)
		hydra.run
		response = request.response
		noko_html = Nokogiri::HTML(response.body)
		noko_html.css('metadata')
	end

	def self.get_pad_data
		# This was the old way of getting sirius xm now-playing data
		# Now it seems to return the same thing over and over
		puts "Getting Sirius XM pad data..."
		timestamp_data = Nokogiri::HTML(open(PAD_DATA_URL))
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