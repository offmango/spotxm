class TrackWorker
  include Sidekiq::Worker

  def perform
  	Track.save_current_playlist
  end

end