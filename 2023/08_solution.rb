documents = File.open('08_input.txt', 'r').read

Node = Struct.new(:left, :right)
NODE_REGEX = /(?<id>\w+) = \((?<left>\w+), (?<right>\w+)\)/

INSTRUCTIONS = {
  'L' => :left,
  'R' => :right
}

# Part 1:
instructions = documents.lines[0].strip.split('')
network = documents.lines[2..-1].reduce({}) do |ntwrk, node|
  id, left, right = node.strip.match(NODE_REGEX).captures
  ntwrk[id] = Node.new(left:, right:)
  ntwrk
end

node = 'AAA'; count = 0
result = instructions.cycle.reduce({ node:, count: }) do |current, instruction|
  break current if current[:node] == 'ZZZ'
  node = network[current[:node]].send(INSTRUCTIONS[instruction])
  count = current[:count].next

  { node:, count: }
end

p result

# Part 2:
starts = network.keys.find_all { |instruction| instruction[-1] == 'A' }
distances = starts.map do |start|
  instructions.cycle.reduce({ node: start, count: 0}) do |current, instruction|
    break current if current[:node][-1] == 'Z'
    node = network[current[:node]].send(INSTRUCTIONS[instruction])
    count = current[:count].next

    { node:, count: }
  end
end

solution = distances.map { |result| result[:count] }.reduce(&:lcm)
p distances
p solution
