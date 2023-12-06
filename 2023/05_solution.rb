almanac = File.open('05_input.txt', 'r').read

format = lambda do |line|
  destination, source, length = line.strip.scan(/\d+/).map(&:to_i)

  source_range = (source...(source + length))
  destination_range = (destination...(destination + length))
  
  { source_range:, destination_range: }
end

# Part 1:
seeds = almanac.lines.first.scan(/\d+/).map(&:to_i)

seed_to_soil = almanac.lines.values_at(3..30).map(&format)
soil_to_fertilizer = almanac.lines.values_at(33..47).map(&format)
fertilizer_to_water = almanac.lines.values_at(50..87).map(&format)
water_to_light =  almanac.lines.values_at(90..117).map(&format)
light_to_temperature = almanac.lines.values_at(120..165).map(&format)
temperature_to_humidity = almanac.lines.values_at(168..177).map(&format)
humidity_to_location = almanac.lines.values_at(180..196).map(&format)

soils = seeds.map do |seed|
  mapping = seed_to_soil.find { |m| m[:source_range].include?(seed) }
  next seed if mapping.nil?

  index = seed - mapping[:source_range].begin
  mapping[:destination_range].begin + index
end

fertilizers = soils.map do |soil|
  mapping = soil_to_fertilizer.find { |m| m[:source_range].include?(soil) }
  next soil if mapping.nil?
  index = soil - mapping[:source_range].begin
  mapping[:destination_range].begin + index
end

waters = fertilizers.map do |fertilizer|
  mapping = fertilizer_to_water.find { |m| m[:source_range].include?(fertilizer) }
  next fertilizer if mapping.nil?
  index = fertilizer - mapping[:source_range].begin
  mapping[:destination_range].begin + index
end

lights = waters.map do |water|
  mapping = water_to_light.find { |m| m[:source_range].include?(water) }
  next water if mapping.nil?
  index = water - mapping[:source_range].begin
  mapping[:destination_range].begin + index
end

temperatures = lights.map do |light|
  mapping = light_to_temperature.find { |m| m[:source_range].include?(light) }
  next light if mapping.nil?
  index = light - mapping[:source_range].begin
  mapping[:destination_range].begin + index
end

humidities = temperatures.map do |temperature|
  mapping = temperature_to_humidity.find { |m| m[:source_range].include?(temperature) }
  next temperature if mapping.nil?
  index = temperature - mapping[:source_range].begin
  mapping[:destination_range].begin + index
end

locations = humidities.map do |humidity|
  mapping = humidity_to_location.find { |m| m[:source_range].include?(humidity) }
  next humidity if mapping.nil?
  index = humidity - mapping[:source_range].begin
  mapping[:destination_range].begin + index
end

puts "Solution: #{locations.min}"
