require 'optparse'
require_relative './lib/billing/taxes'



module Core
    class Main
        def initialize
            #Options for easy execution
            options = {}
            OptionParser.new do |opt|
                opt.on('--input ') { |o| options[:input] = o.gsub("\\n","\n") }
            end.parse!

            
            interactions = Billing::UserInteractions.new
            receipt      = Billing::Receipt.new
            if options.empty?
                interactions.new_bill 
                product_list = interactions.read_multiple_lines 
            else
                product_list = interactions.format_input options[:input]+"#"
            end
            product_list_with_taxes = receipt.generate_receipt product_list
            receipt.print_receipt product_list_with_taxes
        end
    end
end



Core::Main.new