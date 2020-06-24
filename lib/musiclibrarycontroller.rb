class MusicLibraryController  
 

    # creates a new MusicImporter object, passing in the 'path' value
    # the 'path' argument defaults to './db/mp3s'
    # invokes the #import method on the created MusicImporter object

     def initialize(path = './db/mp3s')             
        importer = MusicImporter.new(path)         
        importer.import                            
      end   
      
      # welcomes the user 
      # asks the user for input 
      # loops and asks for user input until they type in exit 

      def call   
        input = ''

    while input != 'exit'
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.chomp

      case input
      when 'list songs'    
        self.list_songs     #  triggers #list_songs
      when 'list artists'  
        self.list_artists   # triggers #list_artists
      when 'list genres'    
        self.list_genres    # triggers #list_genres
      #when 'list artists'   
        #self.list_artists
      when 'list artist'    
        self.list_songs_by_artist   # triggers #list_songs_by_artist
      when 'list genre'      
        self.list_songs_by_genre   # triggers #list_songs_by_genre
      when 'play song'     
        self.play_song       #  triggers #play_song
      else
        "Type in a valid request please"
      end
    end
   end 
 

   # prints all songs in the music library in a numbered list (alphabetized by song name)
   # is not hard-coded
   def list_songs 
      Song.all.sort {|a, b| a.name <=> b.name}.each.with_index(1) do |song, index|
        puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      end
   end 

   #  prints all artists in the music library in a numbered list (alphabetized by artist name)
   def list_artists
      artists = Artist.all.sort {|a,b| a.name <=> b.name}
      artists.each.with_index(1) {|artist, i| puts "#{i}. #{artist.name}"}
   end 

    # prints all genres in the music library in a numbered list (alphabetized by genre name)
    def list_genres 
        genres = Genre.all.sort {|a,b| a.name <=> b.name}
        genres.each.with_index(1) {|genre, i| puts "#{i}. #{genre.name}"}
    end 



    def list_songs_by_artist # prompts the user to enter an artist
        puts "Please enter the name of an artist:"
        input = gets.strip 

        # accepts user input
        # prints all songs by a particular artist in a numbered list (alphabetized by song name)
        # does nothing if no matching artist is found

        if artist = Artist.find_by_name(input)
          artist.songs.sort { |a,b| a.name <=> b.name }.each.with_index(1) do |song, i|
            puts "#{i}. #{song.name} - #{song.genre.name}"
          end
        end
      end  



      def list_songs_by_genre # prompts the user to enter a genre
        puts "Please enter the name of a genre:"
        input = gets.strip 

       # accepts user input
       # prints all songs by a particular genre in a numbered list (alphabetized by song name)
       # does nothing if no matching genre is found
    
        if genre = Genre.find_by_name(input)
          genre.songs.sort { |a,b| a.name <=> b.name }.each.with_index(1) do |song, i|
            puts "#{i}. #{song.artist.name} - #{song.name}"
          end
        end
      end  

     
      def play_song # prompts the user to choose a song from the alphabetized list output by #list_songs
        puts "Which song number would you like to play?"
        input = gets.chomp.to_i  

      #accepts user input
      #upon receiving valid input 'plays' the matching song from the alphabetized list output by #list_songs
      #does not 'puts' anything out if a matching song is not found
      #checks that the user entered a number between 1 and the total number of songs in the library
    
        # self.list_songs
        songs = Song.all
        # songs.sort {|a,b| a.name <=> b.name}
    
        if (1..songs.length).include?(input)
          song = Song.all.sort{ |a, b| a.name <=> b.name }[input - 1]
        end
        puts "Playing #{song.name} by #{song.artist.name}" if song
      end
    

end