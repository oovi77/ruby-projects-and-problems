# frozen_string_literal: true

class BaseBallPlayer
  def initialize(hits, walks, at_bats)
    @hits = hits
    @walks = walks
    @at_bats = at_bats
  end

  def batting_average
    @hits.to_f / @at_bats
  end

  def on_base_percentage
    (@hits + @walks).to_f / @at_bats
  end
end

t1 = BaseBallPlayer.new(1.2, 3.2, 2)
p t1.batting_average
p t1.on_base_percentage

class Person
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end

  attr_reader :first_name, :last_name

  def full_name
    "#{first_name} #{last_name}"
  end
end

t1 = Person.new('James', 'Bond')
p t1.full_name

module MathHelpers
  def exponent(n1, n2)
    n1**n2
  end
end

class Calculator
  include MathHelpers
  def square_root(num)
    exponent(num, 0.5)
  end
end

t1 = Calculator.new
p t1.square_root(25)
p t1.square_root(81)
