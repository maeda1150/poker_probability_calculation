require 'bigdecimal'
# mol 分子 Molecular
# den 分母 Denominator
def to_percent(mol, den)
  cut_below_two_digits((mol / den.to_f * 100).to_s)
end

def cut_below_two_digits(number)
  BigDecimal((number).to_s).ceil(2).to_f
end

def split_number_and_suit(input)
  splited = input.split('')
  numbers = %w[0 1 2 3 4 5 6 7 8 9]
  result = []
  next_flg = false
  max = splited.size
  splited.each_with_index do |s, i|
    if next_flg
      next_flg = false
      next
    end

    if numbers.include?(s)
      if i < max
        if numbers.include?(splited[i + 1])
          result << s + splited[i + 1]
          next_flg = true
        else
          result << s
        end
      end
    else
      result << s
    end
  end
  result
end

def build_message_hands(hands)
  messages = []
  hands.each do |hand|
    messages << "#{hand.number}#{hand.suit}"
  end
  messages
end
