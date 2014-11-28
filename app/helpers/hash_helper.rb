module HashHelper
  ############
  ### Hash ###
  ############

  # Returns a specific value from the given hash (or the default value if not set).
  def get_value(key, hash, default_value = nil)
    value = hash.key?(key) ? hash[key] : default_value
    value = default_value if value.nil? && !default_value.nil?
    value
  end

  # Removes and returns a specific value from the given hash (or the default value if not set).
  def pop_value(key, hash, default_value = nil)
    symbolize_keys(hash)
    value = get_value(key.to_sym, hash, default_value)
    hash.delete(key)
    value
  end

  # all keys of the given hash symbolize.
  def symbolize_keys(hash)
    hash.replace(hash.symbolize_keys)
  end
end
