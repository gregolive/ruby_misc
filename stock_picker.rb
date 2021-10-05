# frozen_string_literal: true

# Determines the best day to have bought and sold a stock
class Stocks
  attr_accessor :difference, :buy, :sell

  attr_reader :prices

  def initialize(prices)
    @difference = 0
    @buy = 0
    @sell = 0
    @prices = prices
  end

  def stock_picker
    @prices.each do |price|
      current_index = prices.index(price)
      num_days = prices.length - 1
      check_difference(price, num_days, current_index)
    end
    p [@buy, @sell]
  end

  def check_difference(price, num_days, current_index)
    while current_index < num_days
      if (@prices[num_days] - price) > difference
        @difference = prices[num_days] - price
        @buy = current_index
        @sell = num_days
      end
      num_days -= 1
    end
  end
end

Stocks.new([17, 3, 6, 9, 15, 8, 6, 1, 10]).stock_picker
