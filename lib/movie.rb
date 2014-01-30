require 'open3'
module Jwthumbs


	class Movie

		attr_reader :file_path, :duration
		attr_accessor :outdir, :thumb_rate_seconds, :thumb_width, :vttfile, :spritefile
		
		def initialize(file_path=nil, options={})

			raise Errno::ENOENT, "the file '#{file_path}' does not exist" unless File.exists?(file_path)

			command = "ffprobe -i #{file_path} -show_format | grep duration"
			output = Open3.popen3(command) { |stdin, stdout, stderr| stderr.read }
			output[/Duration: (\d{2}):(\d{2}):(\d{2}\.\d{2})/]
			@duration = ($1.to_i*60*60) + ($2.to_i*60) + $3.to_f
			@file_path = file_path
			@thumb_rate_seconds = options[:thumb_rate_seconds] ||= @duration/10
			@thumb_width = options[:thumb_width] ||= 100
			@spritefile = options[:spritefile] ||= "#{File.basename(@file_path)}_sprite.jpg"
			@vttfile_name = options[:vttfile_name] ||= "thumbs.vtt"
			@outdir = options[:thumb_outdir] ||= "output/thumbs_#{Time.now.to_i.to_s}"
			@vttfile = File.basename(@file_path, File.extname(@file_path))+"_"+@vttfile_name		

		end


		def create_thumbs
			Shutter.new(self)
		end



	end
end