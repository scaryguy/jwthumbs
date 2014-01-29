require "jwthumbs/version"
require 'movie'
require 'shutter'
require 'logger'

module Jwthumbs
  		def self.logger=(log)
		    @logger = log
		end

		  # Get FFMPEG logger.
		  #
		  # @return [Logger]
		def self.logger
		    return @logger if @logger
		    logger = Logger.new(STDOUT)
		    logger.level = Logger::INFO
		    @logger = logger
		end

end
