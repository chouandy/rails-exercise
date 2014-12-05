class IdentityValidator < ActiveModel::EachValidator
  CITY_POINT = { A:10, B:11, C:12, D:13, E:14, F:15, G:16, H:17, I:34, J:18, K:19, M:21, N:22, O:35, P:23, Q:24, T:27, U:28, V:29, W:32, X:30, Z:33 }
  MULTIPLIER = '19876543211'

  def validate_each(record, attribute, value)
    is_valid = false
    if value =~ /^[a-zA-Z][12][0-9]{8}$/
      id_multiplier = CITY_POINT[value.chars.first.upcase.to_sym].to_s + value[1..9]
      total = 0
      id_multiplier.chars.each_with_index do |value, index|
        total = total + value.to_i * MULTIPLIER.chars.at(index).to_i
      end
      is_valid = true if total % 10 == 0
    end
    unless is_valid
      record.errors.add(attribute, :wrong_identity, options) unless is_valid
    end
  end
end
