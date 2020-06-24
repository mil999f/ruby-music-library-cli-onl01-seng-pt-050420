module Concerns::Findable  # defines a module named Concerns::Findable (FAILED - 1) 


    def find_by_name(name)  
        self.all.detect{|song| song.name == name}
    end 

    def find_or_create_by_name(name) # is added as a class method to classes that extend the module (FAILED - 1)
        self.find_by_name(name) || self.create(name) 
    end 

end