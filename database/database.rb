class Database
    def initialize file
        begin
            @file = File.open(file, 'r')
        rescue StandardError => e
            puts e.message
        end
    end

    def get_data
        begin 
            array = @file.read.split(",")
            @file.close
            array
        rescue StandardError => e
            default_data
        end
    end

    def default_data
        ["book","chocolate bar","box of chocolates","packet of headache pills","boxes of chocolates"]
    end

end