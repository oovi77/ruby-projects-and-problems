puts "Hello Stock Picker Problem"

#Problem Description

=begin
    Implement a method #stock_picker that takes in an array of stock prices,
    one for each hypothetical day. It should return a pair of days representing
    the best day to buy and the best day to sell. Days start at 0.

    Ex:

      > stock_picker([17,3,6,9,15,8,6,1,10])
      => [1,4]  # for a profit of $15 - $3 == $12

=end

=begin

1. need a variable for the index of buying the stock and selling it
2. need to loop through all possible combos of buying and selling
3. pick the combo that yields the highest profit
4. need to make note that you have to buy first before you can sell


=end

def stock_picker(prices)

    buy_index = 0
    sell_index = 0
    profit = 0
    greatest_profit = -999999 #depending on how question is worded can make this the first two stock days
    pair_of_days = []


    prices.each_with_index do |val, idx|
        for i in (idx+1 .. prices.length-1)
            
            profit = prices[i] - val
            #puts "comparing #{val} with #{prices[i]}, profit = #{profit}"
            if profit >= greatest_profit
                greatest_profit = profit
                pair_of_days = [idx, i]
            end
        end
    end

    puts "pair is: #{pair_of_days}"

end

p1 = [17,3,6,9,15,8,6,1,10] #best combo is [1, 4]
p2 = [17, 3, 6, 9, 15]
p3 = [1, 2, 3, 5, 99] #best combo is [0, 4]
p4 = [99, 51, 25, 6, 1] #best combo is [0, 4]

stock_picker(p1)
stock_picker(p3)
stock_picker(p4)