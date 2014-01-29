module Jwthumbs
	class Shutter
		attr_accessor :sprite
		def initialize(movie, options)
			@movie = movie
			@options = options
			@outdir = options[:outdir]
			@thumb_rate_seconds = options[:thumb_rate_seconds]
			@skip_first = options[:skip_first]
			@thumb_width = options[:thumb_width]
			@spritefile = options[:spritefile]
			run
		end

		def options
			@options
		end


		def images
			images = []
			Dir.glob("#{@outdir}/*.jpg") do |image|
				images.push(image)
			end
			images
		end

		def sprite
			@outdir+"/"+@spritefile
		end


		protected

		def run
			take_snaps
			process_images(images)
			coords = get_geometry(images.first)
			gridsize = Math.sqrt(images.length).ceil.to_i
			return create_sprite(@outdir, @spritefile, coords, gridsize)
		end

		def create_sprite(outdir, spritefile, coords, gridsize)
			grid = "#{gridsize}x#{gridsize}"
    		cmd = "montage #{outdir}/thumbnail*.jpg -tile #{grid} -geometry #{coords} #{outdir}/#{spritefile}"
			Jwthumbs.logger.info(system(cmd))
			
		end


		def take_snaps
			rate = "1/#{@thumb_rate_seconds}"
			`mkdir -p #{@outdir}`
			cmd = "ffmpeg -i #{@movie.file_path} -f image2 -bt 20M -vf fps=#{rate} -aspect 16:9 #{@outdir+"/thumbnail%03d.jpg"}"
			Jwthumbs.logger.info(system(cmd))
		end


		def process_images(images)
			command ="mogrify -geometry #{@thumb_width}x #{images.join(" ")}"
			Jwthumbs.logger.info(system(command))
		end


		def get_geometry(file)
			`identify -format "%g" #{file}`.strip
		end

	end
end