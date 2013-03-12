require 'clockwork'
require 'sidekiq'
#include Clockwork

Dir["app/workers/*"].each {|worker| load worker } 

module Clockwork

	handler do |job|
  		puts "Running #{job}"
		end

	every 2.minutes, 'track_worker.perform_async' do
   		TrackWorker.perform_async
	end
end