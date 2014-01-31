module Jwthumbs
	class Shutter
		attr_accessor :sprite
		def initialize(movie)
			@movie = movie
			@sprite = @movie.outdir+"/"+@movie.spritefile
			run
		end

		protected

		def images
			my_images = []
			Dir.glob("#{@movie.outdir}/thumbnail*.jpg") do |image|
				if image.include?("thumbnail001") 
					File.delete(image) 
				else
					my_images.push(image)
				end
			end
			@images = my_images
		end

		def run
			take_snaps
			process_images(images)
			coords = get_geometry(@images.first)
			gridsize = Math.sqrt(@images.length).ceil.to_i
			gridsize = gridsize <= 0 ? 1 : gridsize
			create_sprite(@movie.outdir, @movie.spritefile, coords, gridsize)
			create_vtt(@movie, @movie.spritefile, @images.length, coords, gridsize)
		end

		def create_vtt(movie, spritefile, images_count, coords, gridsize)
			Vtt.new(movie, spritefile, images_count, coords, gridsize)
		end

		def create_sprite(outdir, spritefile, coords, gridsize)
			grid = "#{gridsize}x#{gridsize}"
    		cmd = "montage #{outdir}/thumbnail*.jpg -tile #{grid} -geometry #{coords} #{outdir}/#{spritefile}"
			Jwthumbs.logger.info(system(cmd))
		end


		def take_snaps
			rate = "1/#{@movie.seconds_between}"
			`mkdir -p #{@movie.outdir}`
			cmd = "ffmpeg -i #{@movie.file_path} -f image2 -bt 20M -vf fps=#{rate} -aspect 16:9 #{@movie.outdir+"/thumbnail%03d.jpg"}"
			Jwthumbs.logger.info(cmd)
			system(cmd)
		end


		def process_images(images)
			command ="mogrify -geometry #{@movie.thumb_width}x #{images.join(" ")}"
			Jwthumbs.logger.info(command)
			system(command)
		end


		def get_geometry(file)
			`identify -format "%g" #{file}`.strip
		end

	end
end