class Genre    

    extend Concerns::Findable 

    @@all = []

    attr_accessor :name 

    def initialize(name) 
        @name = name  
        @songs = []  # creates a 'songs' property set to an empty array (genre has many songs)
        #@@all << self
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

    def self.create(genre)
        genre = Genre.new(genre)
        genre.save 
        genre 
    end  

    def songs # returns the genre's 'songs' collection (genre has many songs)
        @songs 
    end 

    def artists                                        # returns a collection of artists for all of the genre's songs (genre has many artists through songs)
        self.songs.collect{|song| song.artist}.uniq    # does not return duplicate artists if the genre has more than one song by a particular artist (genre has many artists through songs)
    end                                                # collects artists through its songs instead of maintaining its own @artists instance variable (genre has many artists through songs)


end