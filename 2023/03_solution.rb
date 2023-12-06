engine_schematic = File.open('03_input.txt', 'r').read

SYMBOL_REGEX = /[\W&&[^.]]/

# Part 1
solution = engine_schematic.lines.map.each_with_index do |line, index|
  previous = index > 0 ? engine_schematic.lines[index - 1] : nil
  following = index < engine_schematic.lines.length - 1 ? engine_schematic.lines[index + 1] : nil


  numbers = line.enum_for(:scan, /\d+/).map do |match|
    number = match.to_i
    indices = (Regexp.last_match.begin(0))..(Regexp.last_match.end(0) - 1)

    part = indices.any? do |position|
      not_first = position > 0
      not_last = position < line.strip.length - 1

      (not_first && line[position - 1].match?(SYMBOL_REGEX)) ||
      (not_last && line[position + 1].match?(SYMBOL_REGEX)) ||
      (
        previous && (
          (not_first && previous[position - 1].match?(SYMBOL_REGEX)) ||
          previous[position].match?(SYMBOL_REGEX) ||
          (not_last && previous[position + 1].match?(SYMBOL_REGEX))  
        )
      ) ||
      (
        following && (
          (not_first && following[position - 1].match?(SYMBOL_REGEX)) ||
          following[position].match?(SYMBOL_REGEX) ||
          (not_last && following[position + 1].match?(SYMBOL_REGEX))  
        )
      )
    end

    part ? number : 0
  end

  numbers
end.flatten.sum

puts "Solution 1: #{solution}"

# Part 2

solution = engine_schematic.lines.map.each_with_index do |line, index|
  previous = index > 0 ? engine_schematic.lines[index - 1] : nil
  following = index < engine_schematic.lines.length - 1 ? engine_schematic.lines[index + 1] : nil

  gear_indices = line.enum_for(:scan, /\*/).map { |match| Regexp.last_match.begin(0)}

  next unless gear_indices.length > 0

  top_parts = previous&.enum_for(:scan, /\d+/)&.map do |match|
    number = match.to_i
    indices = (Regexp.last_match.begin(0))..(Regexp.last_match.end(0) - 1)
    { number:, indices: }
  end

  inline_parts = line.enum_for(:scan, /\d+/).map do |match|
    number = match.to_i
    indices = (Regexp.last_match.begin(0))..(Regexp.last_match.end(0) - 1)
    { number:, indices: }
  end

  bottom_parts = following&.enum_for(:scan, /\d+/)&.map do |match|
    number = match.to_i
    indices = (Regexp.last_match.begin(0))..(Regexp.last_match.end(0) - 1)
    { number:, indices: }
  end

  ratios = gear_indices.map do |gear|
    parts = [
      top_parts.find_all { |part| part[:indices].include?(gear - 1) || part[:indices].include?(gear) || part[:indices].include?(gear + 1) },
      inline_parts.find_all { |part| part[:indices].include?(gear - 1) || part[:indices].include?(gear) || part[:indices].include?(gear + 1) },
      bottom_parts.find_all { |part| part[:indices].include?(gear - 1) || part[:indices].include?(gear) || part[:indices].include?(gear + 1) }
    ].flatten.map { |part| part[:number]}

    
    parts.length == 2 ? parts.reduce(:*): 0
  end

  ratios
end.flatten.compact.sum

puts "Solution 2: #{solution}"
