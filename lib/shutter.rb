module Jwthumbs
	class Shutter

		def initialize(movie, options)
			@movie = movie
			@options = options
			@outdir = options[:outdir]
			@thumb_rate_seconds = options[:thumb_rate_seconds]
			@skip_first = options[:skip_first]
			@thumb_width = options[:thumb_width]
			take_snaps
		end

		def options
			@options
		end


		def big_images
			images = []
			Dir.glob("#{@outdir}/*.jpg") do |image|
				images.push(image)
			end
			images
		end


		protected


		def take_snaps
			rate = "1/#{@thumb_rate_seconds}"
			`mkdir -p #{@outdir}`
			cmd = "ffmpeg -i #{@movie.file_path} -f image2 -bt 20M -vf fps=#{rate} -aspect 16:9 #{@outdir+"/thumnail%03d.jpg"}"
			Jwthumbs.logger.info(system(cmd))
			process_images(big_images)
		end


		def process_images(big_images)
			command ="mogrify -geometry #{@thumb_width}x #{big_images.join(" ")}"
			Jwthumbs.logger.info(system(command))
		end


		def get_geometry(file)
			`identify -format "%g" #{file}`.strip
		end

	end
end