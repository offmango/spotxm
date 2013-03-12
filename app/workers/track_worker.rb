class TrackWorker
  include Sidekiq::Worker

  def perform
  	Track.save_current_playlist
  	# reindex if needed
  	Sunspot.commit_if_dirty
  end

end