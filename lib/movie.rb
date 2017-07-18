require 'open3'
module Jwthumbs

  class Movie

    attr_reader :file_path, :duration
    attr_accessor :outdir, :seconds_between, :thumb_width, :vttfile, :spritefile, :clear_files, :gallery_mode_on, :file_server, :relative_path
    
    def initialize(file_path=nil, options={})
      raise Errno::ENOENT, "the file '#{file_path}' does not exist" unless File.exists?(file_path)

      command = "ffprobe -i #{file_path} -show_format | grep duration"
      output = Open3.popen3(command) { |stdin, stdout, stderr| stderr.read }
      output[/Duration: (\d{2}):(\d{2}):(\d{2}\.\d{2})/]
      @duration = ($1.to_i*60*60) + ($2.to_i*60) + $3.to_f

      @file_path = file_path
      @clear_files = options[:clear_files] ||= true
      @seconds_between = options[:seconds_between] ||= @duration.to_i/10
      @thumb_width = options[:thumb_width] ||= 100 
      @spritefile = options[:spritefile] ||= "#{File.basename(@file_path, File.extname(@file_path))}_sprite.jpg"
      @vttfile = options[:vttfile_name] ||= "#{File.basename(@file_path, File.extname(@file_path))}_thumbs.vtt"
      @outdir = options[:thumb_outdir] ||= "output/thumbs_#{Time.now.to_i.to_s}"
      @file_server = options[:file_server] || ''
      @relative_path = options[:relative_path] || false
      @file_server = @file_server + "/" unless @file_server[-1] == '/'
      @gallery_mode_on = options[:gallery_mode_on] ||= false
    end

    def create_thumbs!
      Shutter.new(self)
    end
  end

end
