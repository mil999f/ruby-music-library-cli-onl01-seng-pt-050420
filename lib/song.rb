class Song   

    @@all = [] # is initialized as an empty array

    attr_accessor :name, :artist, :genre 
    # can be invoked with an optional second argument, an Artist object to be assigned to the song's 'artist' property (song belongs to artist)
    # can be invoked with an optional third argument, a Genre object to be assigned to the song's 'genre' property

    def initialize(name, artist= nil, genre= nil ) 
        @name = name 
        self.artist= artist if artist # invokes #artist= instead of simply assigning to an @artist instance variable to ensure that associations are created upon initialization
        self.genre= genre if genre # invokes #genre= instead of simply assigning to a @genre instance variable to ensure that associations are created upon initialization
        #@@all << self 
    end 

    def self.all # returns the class variable @@all
        @@all 
    end 

    def self.destroy_all # resets the @@all class variable to an empty array
        @@all.clear 
    end 

    def save # adds the Song instance to the @@all class variable 
        @@all << self 
    end 

    def self.create(song) # initializes, saves, and returns the song
        song = Song.new(song) 
        song.save 
        song
    end  

    def artist= (artist) 
        @artist = artist
        artist.add_song(self) # invokes Artist#add_song to add itself to the artist's collection of songs (artist has many songs)
    end 

    def genre= (genre)                                          # adds the song to the genre's collection of songs (genre has many songs)
        @genre = genre                                        
        genre.songs << self unless genre.songs.include?(self)   #does not add the song to the genre's collection of songs if it already exists therein
    end 

    def self.find_by_name(name) #  finds a song instance in @@all by the name property of the song
        @@all.detect{|song| song.name == name} 
    end 

    def self.find_or_create_by_name(name)    # returns (does not recreate) an existing song with the provided name if one exists in @@all
        find_by_name(name) || create(name)   # invokes .find_by_name instead of re-coding the same functionality
    end                                      # creates a song if an existing match is not found,  invokes .create instead of re-coding the same functionality

    
    def self.new_from_filename(filename)

       array = filename.split(" - ")                            # initializes a song based on the passed-in filename
       song_name = array[1]
       artist_name = array[0]
       genre_name = array[2].split(".mp3").join

       artist = Artist.find_or_create_by_name(artist_name)      # invokes the appropriate Findable methods so as to avoid duplicating objects
       genre = Genre.find_or_create_by_name(genre_name)
       self.new(song_name, artist, genre)
    end 

    def self.create_from_filename(filename)   #initializes and saves a song based on the passed-in filename (FAILED - 1)

        self.new_from_filename(filename).save
    end
    
end