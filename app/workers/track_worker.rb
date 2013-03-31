class TrackWorker
  	include Sidekiq::Worker
	sidekiq_options :timeout => 60, :retry => false	

  	def perform
  		Track.save_current_playlist
  		# reindex if needed
  		Sunspot.commit_if_dirty
  	end

end