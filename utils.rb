require 'bigdecimal'
# mol 分子 Molecular
# den 分母 Denominator
def to_percent(mol, den)
  cut_below_two_digits((mol / den.to_f * 100).to_s)
end

def cut_below_two_digits(number)
  BigDecimal((number).to_s).ceil(2).to_f
end
