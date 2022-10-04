require_relative '../..//database/database'

module Billing
    #Global variables for taxes calculations
    $basic_sales_tax            = 0.10
    $import_duty                = 0.05
    $basic_sales_tax_exceptions = []

    #A class defined for the interactions on console
    class UserInteractions

        def new_bill 
            #Show an instruction on CLI
            p "Please insert your product list and type '#' when you have finished: "
        end

        def read_multiple_lines
            #Read a multiple-line input
            $/ = "#"  
            user_input = STDIN.gets
            p user_input 
            format_input user_input
        end

        def format_input user_input
            #Transforming multi-lines into array items "rows and columns" and saving space by removing "at "
            #p "------ Formatting... ------"
            begin
                cart_list_array = []
                user_input.gsub("#","").gsub("at ","").split("\n").each { |string|
                    # Regex for input validation
                    #regex = /^(\d)((\s*\w*\s)*)(\d+\.\d+)$/ #Only decimals
                    regex = /^(\d)((\s*\w*\s)*)((\d+\.\d+)|(\d+))$/
                    if string.match(regex)
                        # Destructuring regex groups
                        units, product, at, price = string.match(regex).captures
                        cart_list_array << [units,product.strip,price]

                    else
                        # Exit the program if the input is invalid (Doesn't match with the regex)
                        raise Exception.new "The input is not matching, check the line '#{string}'"
                    end
                }
                cart_list_array
            rescue Exception => e 
                p e.message
                return e.message
            end
        end
    end

    class Receipt
        def initialize
            database = Database.new("./database/tax_exceptions.txt").get_data
            $basic_sales_tax_exceptions = database
            
            # Only uniq values
            $basic_sales_tax_exceptions.uniq!
            @totals =  { total_items: 0, total_taxes: 0, net_total: 0}
        end
        
        def net_price product_list
            net_price_product_list = []
            product_list.each { |item|
                item[2] = item[2].to_f * item[0].to_f
                @totals[:total_items] += item[0].to_f
                @totals[:net_total]   += item[2] 
                net_price_product_list << item
            }
            net_price_product_list
        end

        def apply_taxes product_list 
            basic_taxes_product_list = []
            product_list.each { |item|
                tax = 0
                tax += $import_duty if item[1].include? "imported"
                tax += $basic_sales_tax unless $basic_sales_tax_exceptions.include? item[1].gsub("imported","").strip

                taxes   = item[2].to_f * tax
                item[2] = (taxes+ item[2].to_f).round 2
                @totals[:total_taxes] += taxes

                basic_taxes_product_list << item
            }
            basic_taxes_product_list
        end

        def generate_receipt product_list
            #Receipt tasks
            if product_list.kind_of?(Array)
                p "------ Generating receipt ------"
                #Generate the net price
                net_price_list = net_price product_list
                #Apply taxes
                basic_tax_list = apply_taxes net_price_list
            end
        end

        def print_receipt product_list
            if product_list.kind_of?(Array)
                p "------ Printing ------"
                #Print receipt for a good visualization
                product_list.each { |item|
                    p "#{item[0]} #{item[1]}: #{'%.2f' % item[2]}"
                }
                p "Sales Taxes: #{'%.2f' % (@totals[:total_taxes].round 2) }"
                p "Total: #{'%.2f' % ((@totals[:total_taxes] + @totals[:net_total]).round(2))}"
            end
        end
    end
end





