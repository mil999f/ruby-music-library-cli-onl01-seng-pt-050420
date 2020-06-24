class Artist   

    extend Concerns::Findable 

    @@all = []

    attr_accessor :name 

    def initialize(name) 
        @name = name  
        #@@all << self  
        @songs = [] # creates a 'songs' property set to an empty array (artist has many songs)
    end 

    def self.all 
        @@all  
    end 

    def self.destroy_all 
        @@all.clear
    end 

    def save 
        @@all << self 
    end 

    def self.create(artist) 
        artist = Artist.new(artist) 
        artist.save 
        artist
    end 

    def songs # returns the artist's 'songs' collection (artist has many songs)
        @songs  
    end 

    def add_song(song)                                       # assigns the current artist to the song's 'artist' property (song belongs to artist)
        song.artist = self unless song.artist                # does not assign the artist if the song already has an artist
        @songs << song unless @songs.include?(song)          # adds the song to the current artist's 'songs' collection,  does not add the song to the current artist's collection of songs if it already exists therein
    end 

    def genres                                  # returns a collection of genres for all of the artist's songs (artist has many genres through songs) 
        @songs.collect{|song| song.genre}.uniq  # does not return duplicate genres if the artist has more than one song of a particular genre (artist has many genres through songs)
    end                                         # collects genres through its songs instead of maintaining its own @genres instance variable (artist has many genres through songs)

end