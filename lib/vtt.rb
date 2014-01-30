module Jwthumbs
	class Vtt

		def initialize(movie, spritefile, images_count, coords, gridsize)
			create(movie, spritefile, images_count, coords, gridsize)
		end

		def create(movie, spritefile, images_count, coords, gridsize)

			whxy = coords.split(/\+([^.]*)$/)
			w,h = whxy.first.split("x").map {|x| x.to_i}
			x,y = whxy.last.split("+").map {|x| x.to_i}
			thumb_rate = movie.thumb_rate_seconds
			count = images_count

			vtt = ["WEBVTT",""]
			clipstart = 0
			clipend = clipstart + thumb_rate
			

			count.times do |x|
				x = x+1
				xywh = get_grid_coordinates(x,gridsize,w,h)
				start = get_time_str(clipstart)
				clip_end = get_time_str(clipend)



				vtt.push("#{start} --> #{clip_end}")
				vtt.push("#{spritefile}#xywh=#{xywh}")
				vtt.push("")

				clipstart = clipend
				clipend = clipend + thumb_rate
			end

			vtt_path = movie.outdir+"/"+movie.vttfile
			File.open(vtt_path, 'w+') do |f|

			 	f.write(vtt.join("\n")) 

			end

		end

		protected

		def get_time_str(clipstart)

			Time.at(clipstart).gmtime.strftime('%H:%M:%S')

		end

		def get_grid_coordinates(image_index,gridsize,w,h)

			    y = (image_index - 1)/gridsize
			    x = (image_index -1) - (y * gridsize)
			    imgx = x * w
			    imgy =y * h
				"#{imgx},#{imgy},#{w},#{h}"
			
		end

	end
end