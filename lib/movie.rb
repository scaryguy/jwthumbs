
module Jwthumbs


	class Movie

		attr_reader :file_path
		
		def initialize(file_path=nil, options={})

			raise Errno::ENOENT, "the file '#{file_path}' does not exist" unless File.exists?(file_path)

			#Jwthumbs.logger.info('======== File has been initialized. ===========')
			@file_path = file_path
			@thumb_rate_seconds = options[:thumb_rate_seconds] ||= 45
			@thumb_width = options[:thumb_width] ||= 100
			@skip_first = options[:skip_first] ||= true
			@sprite_name = options[:sprite_name] ||= "sprite.jpg"
			@vttfile_name = options[:vttfile_name] ||= "thumbs.vtt"
			@outdir = options[:thumb_outdir] ||= "thumbs_#{Time.now.to_i.to_s}"
			@timesync_adjust = options[:timesync_adjust] ||= 0.5
			@spritefile = File.basename(@file_path, File.extname(@file_path))+"_"+@sprite_name
			@vttfile = File.basename(@file_path, File.extname(@file_path))+"_"+@vttfile_name
			
			
			@options = {
				thumb_rate_seconds: @thumb_rate_seconds,
				thumb_width: @thumb_width,
				skip_first: @skip_first,
				sprite_name: @sprite_name,
				vttfile_name: @vttfile_name,
				use_unique_outdir: @use_unique_outdir,
				timesync_adjust: @timesync_adjust,
				spritefile: @spritefile,
				vttfile: @vttfile,
				outdir: @outdir
			}
		end

		def file_path
			@file_path
		end

		def spritefile
			@spritefile
		end

		def vttfile
			@vttfile
		end

		def options
			@options
		end

		def outdir
			@outdir
		end

		def create_thumbs
			Shutter.new(self, @options)
		end



	end
end