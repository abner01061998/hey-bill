require 'spec_helper'


describe 'functionalities' do
    
    it 'Should print instructions' do
        text = "Please insert your product list and type '#' when you have finished: "
        expect(@interactions.new_bill).to eq text
    end

    it 'Should format the user input' do
        input = "2 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85#"

        expected_array = [["1", "chocolate bar", "0.85"], ["1", "music CD", "14.99"], ["2", "book", "12.49"]]
        format_input = @interactions.format_input input

        expect(format_input).to match_array expected_array
    end


    it 'Should return a bad input message' do
        input = "2 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85%"
        instruction = @interactions.format_input input

        expect(instruction).to include("The input is not matching")
    end

    it 'Should multiply units with price' do
        input = [[2,"book",12]]
        instruction = @receipt.net_price input

        expect(instruction.size).to eq(1)
        expect(instruction[0][2]).to eq(24)
    end

    it 'Should not apply taxes to books, medical products and food' do
        input = [[1,"book",12]]
        instruction = @receipt.apply_taxes input
        expect(instruction.size).to eq(1)
        expect(instruction[0][2]).to eq(12)
    end

    it 'Should apply basic taxes' do
        input = [[1,"perfume",12]]
        instruction = @receipt.apply_taxes input
        expect(instruction.size).to eq(1)
        expect(instruction[0][2]).to eq(13.2)
    end

    it 'Should apply basic taxes and import duty' do
        input = [[1,"imported perfume",10]]
        instruction = @receipt.apply_taxes input
        expect(instruction.size).to eq(1)
        expect(instruction[0][2]).to eq(11.5)
    end

    it 'Should apply only import duty ' do
        input = [[1,"imported box of chocolates",10]]
        instruction = @receipt.apply_taxes input
        expect(instruction.size).to eq(1)
        expect(instruction[0][2]).to eq(10.5)
    end

    it 'Should print receipt ' do
        input = [[1,"imported box of chocolates",10]]

        expect { @receipt.print_receipt input }.to output(a_string_including "Sales Taxes:").to_stdout
        expect { @receipt.print_receipt input }.to output(a_string_including "Total:").to_stdout
    end
    
end