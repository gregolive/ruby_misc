# Stock picker that uses an array of daily prices to determine the best time to have bought and sold

def stock_picker(prices)
  difference = 0
  sell = 0
  buy = 0

  prices.each { |price|
    current_index = prices.index(price)
    i = prices.length - 1
    
    while (current_index < i)
      if ((prices[i] - price) > difference) then
        difference = prices[i] - price
        buy = current_index
        sell = i
      end
      i -= 1
    end
  }
  p [buy, sell]
end

stock_picker([17,3,6,9,15,8,6,1,10])