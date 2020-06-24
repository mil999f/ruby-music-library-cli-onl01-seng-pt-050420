class MusicImporter  

    attr_accessor :path

    def initialize(path) 
        @path = path 
    end 

    def files  # loads all the MP3 files in the path directory, normalizes the filename to just the MP3 filename with no path
        @files ||= Dir.glob("#{@path}/*.mp3").collect{ |file| file.gsub("#{@path}/", "") }
    end 
https://learn.co/tracks/online-software-engineering-structured/object-oriented-ruby/section-17-final-projects/music-library-cli#
    def import #   imports the files into the library by invoking Song.create_from_filename
        files.each {|file| Song.create_from_filename(file)}
      end



end