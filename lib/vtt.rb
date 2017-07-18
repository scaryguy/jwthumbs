module Jwthumbs
  class Vtt

    def initialize(movie, spritefile, images_count, coords, gridsize)
      @movie = movie
      create(movie, spritefile, images_count, coords, gridsize)
      clear_files if @movie.clear_files

    end

    def create(movie, spritefile, images_count, coords, gridsize)
      whxy = coords.split(/\+([^.]*)$/)
      w,h = whxy.first.split("x").map {|i| i.to_i}
      _x,_y = whxy.last.split("+").map {|i| i.to_i}
      thumb_rate = movie.seconds_between
      if @movie.relative_path
        spritefile = spritefile[1..-1] if spritefile[0] == "/" 
      else
        spritefile = @movie.file_server + spritefile
      end
      count = images_count

      vtt = ["WEBVTT",""]
      clipstart = 0
      clipend = clipstart + thumb_rate
      
      count.times do |i|
        i = i + 1
        xywh = get_grid_coordinates(i, gridsize, w, h)
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
     
    def clear_files
      Dir.glob("#{@movie.outdir}/thumbnail*.jpg") do |image|
        File.delete(image) 
      end
    end

    def get_time_str(clipstart)
      Time.at(clipstart).gmtime.strftime('%H:%M:%S.%L')
    end

    def get_grid_coordinates(image_index,gridsize,w,h)
      y = (image_index - 1)/gridsize
      x = (image_index - 1) - (y * gridsize)
      imgx = x * w
      imgy =y * h
      "#{imgx},#{imgy},#{w},#{h}"  
    end

  end
end
