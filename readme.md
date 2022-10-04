# README

Hey-Bill it's a ruby console application to calculate taxes in a product list

* Basics:
    * Ruby version: 2.7.6
    * Dev Platform: Windows 10

    * System dependencies:
    -rspec
    -rake

* Folder Structure
    * database: all related to the database 
    * lib: to place all logic of the business 
    * spec: to place unit test and integration tests


* Config & running:
    1. Clone the project 
    2. Run `bundle install`
    3. Open the command prompt
    4. cd to the project folder
    5. run ruby main.rb

* Quick run

    For a quick run just add the `--input` argument followed by the product list.
    ```
    cd to Hey-Bill project
    ruby main.rb --input '2 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85'
    ```


* Rules:
    1. When the program asks for the input you must type "#" at the end of your input and press enter.

    2. The program expects a list of products and every item must be separated by a line break.

    3. The input is validated by the following regular expression `/^(\d)((\s*\w*\s)*)(\d+\.\d+)$/` so be careful to follow the pattern, otherwise the program will show you which line isn't matching and will stop.

 
* Database creation:
There is a file called "tax_exceptions.txt" where you can add products except for taxes (books, medical products, food and more). Within this file, you will find a string separated by commas.

    **This program will work even without a .txt file, by using a hard-coded array with the following elements:**

    > book,chocolate bar,box of chocolates,packet of headache pills,boxes of chocolates
    - To add a product you have to place a comma followed by the product name.

    > packet of headache pills,boxes of chocolates, "new_product_without_quotes"

    - To remove a product you have to remove the product name and the comma.

    > box of chocolates,packet of headache pills,boxes of chocolates ~~, "new_product_without_quotes"~~

    - To edit a product you just have to change its name for whatever you want.

    >book -> books


* How to run the test suite?

    To run unit test cases and integration cases just run on the console:

    `rake specs`


## IMPORTANT
There are 2 use cases on the integration module which reflect errors.

### Case 2

Input 
```
1 imported box of chocolates at 10.00
1 imported bottle of perfume at 47.50
```

The generated receipt is

```
1 imported box of chocolates: 10.50
1 imported bottle of perfume: 54.63 <-- Difference here
Sales Taxes: 7.63                   <-- Difference here
Total: 65.13                        <-- Difference here
```

And the expected output is:

```
1 imported box of chocolates: 10.50
1 imported bottle of perfume: 54.65 <-Difference here
Sales Taxes: 7.65                   <-Difference here
Total: 65.15                        <-Difference here
```

Doing calculations by hand:

Both products are imported, so both of them need import duty tax calculation.
The first one is food, so it doesn't apply to basic taxes calculations

The expected result for product #2 has a miscalculation  
- (47.50 * 0.15) + 47.50 = 54.625 not 54.65

### Case 3

Input 
```
1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
3 imported boxes of chocolates at 11.25  
```

The generated receipt is

```
1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
3 imported boxes of chocolates: 35.44   <-Difference here (also in the product name)
Sales Taxes: 7.79                       <-Difference here
Total: 98.26                            <-Difference here
```

And the expected output is:

```
1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
3 imported box of chocolates: 35.55 <-Difference here (also in the product name)
Sales Taxes: 7.90                   <-Difference here
Total: 98.38                        <-Difference here
```

Doing calculations by hand:

The last product is imported and it's food, so it's excepted of basic taxes but not from import duty

The expected result for product #4 has a miscalculation and a different product name
- 3 * 11.25    = 33.75 
- 33.75 * 0.05 = 1.68
- Total = 33.75 + 1.68 = 35.43 not 35.55