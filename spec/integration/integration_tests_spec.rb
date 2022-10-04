require 'spec_helper'
require 'open4'

describe 'functionalities' do
    it 'Should generate receipt for input 1' do

        # Case #1 input
        input = "2 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85#"

        # Show instrunctions 
        expect(@interactions.new_bill).to include "Please insert your product list and"

        # Format input
        formated_input = @interactions.format_input input
        expect(formated_input.size).to eq 3

        # Generate receipt with taxes
        product_list_with_taxes = @receipt.generate_receipt formated_input
        expect((product_list_with_taxes).size).to eq 3

        # Print receipt receipt with taxes
        expect { @receipt.print_receipt product_list_with_taxes}.to output(a_string_including "2 book: 24.98").to_stdout
        expect { @receipt.print_receipt product_list_with_taxes}.to output(a_string_including "1 music CD: 16.49").to_stdout
        expect { @receipt.print_receipt product_list_with_taxes}.to output(a_string_including "1 chocolate bar: 0.85").to_stdout
        expect { @receipt.print_receipt product_list_with_taxes}.to output(a_string_including "Sales Taxes: 1.50").to_stdout
        expect { @receipt.print_receipt product_list_with_taxes}.to output(a_string_including "Total: 42.32").to_stdout

    end 


    it 'Should generate receipt for input 2' do

        # Case #1 input
        input = "1 imported box of chocolates at 10.00
1 imported bottle of perfume at 47.50#"

        # Show instrunctions 
        expect(@interactions.new_bill).to include "Please insert your product list and"

        # Format input
        formated_input = @interactions.format_input input
        expect(formated_input.size).to eq 2

        # Generate receipt with taxes
        product_list_with_taxes = @receipt.generate_receipt formated_input
        expect((product_list_with_taxes).size).to eq 2

        # Print receipt receipt with taxes
        expect { @receipt.print_receipt product_list_with_taxes}.to output(a_string_including "1 imported box of chocolates: 10.50").to_stdout
        expect { @receipt.print_receipt product_list_with_taxes}.to output(a_string_including "1 imported bottle of perfume: 54.65").to_stdout
        expect { @receipt.print_receipt product_list_with_taxes}.to output(a_string_including "Sales Taxes: 7.65").to_stdout
        expect { @receipt.print_receipt product_list_with_taxes}.to output(a_string_including "Total: 65.15").to_stdout

    end

    it 'Should generate receipt for input 3' do

        # Case #1 input
        input = "1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
3 imported boxes of chocolates at 11.25#"

        # Show instrunctions 
        expect(@interactions.new_bill).to include "Please insert your product list and"

        # Format input
        formated_input = @interactions.format_input input
        expect(formated_input.size).to eq 4

        # Generate receipt with taxes
        product_list_with_taxes = @receipt.generate_receipt formated_input
        expect((product_list_with_taxes).size).to eq 4

        # Print receipt receipt with taxes
        expect { @receipt.print_receipt product_list_with_taxes}.to output(a_string_including "1 imported bottle of perfume: 32.19").to_stdout
        expect { @receipt.print_receipt product_list_with_taxes}.to output(a_string_including "1 bottle of perfume: 20.89").to_stdout
        expect { @receipt.print_receipt product_list_with_taxes}.to output(a_string_including "1 packet of headache pills: 9.75").to_stdout
        expect { @receipt.print_receipt product_list_with_taxes}.to output(a_string_including "3 imported box of chocolates: 35.55").to_stdout
        expect { @receipt.print_receipt product_list_with_taxes}.to output(a_string_including "Sales Taxes: 7.90").to_stdout
        expect { @receipt.print_receipt product_list_with_taxes}.to output(a_string_including "Total: 98.38").to_stdout

    end
end