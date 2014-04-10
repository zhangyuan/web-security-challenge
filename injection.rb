SQL_INJECTION_PATTERN_STRING = /^(\w+)'\s+or\s+'(\w*)'\s*=\s*'(\w*)$/
SQL_INJECTION_PATTERN_NUMERAL = /^(\w*)'\s+or\s+\d+\s*=\s*\d+\s*;\s*--$/

def injection_login? (usr, pwd)
  return ((valid_injection? usr) || (valid_injection? pwd))
end

def valid_injection? param
  return false if param.nil?

  match_string_injection?(param) || match_numeral_injection?(param)
end

def match_string_injection?(param)
  # String pattern: {field1}' or '{field2}' = '{field3}
  fields = param.downcase.scan(SQL_INJECTION_PATTERN_STRING)
  return (!fields.empty?) && (fields[0][1].eql?(fields[0][2]))
end

def match_numeral_injection?(param)
  # Numeral pattern: {field1}' or {field2} = {field3}; --
  fields = param.downcase.scan(SQL_INJECTION_PATTERN_NUMERAL)
  return (!fields.empty?) && (fields[0][1].eql?(fields[0][2]))
end