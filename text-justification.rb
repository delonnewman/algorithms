def score(str, length)
  words = str.split(' ')
  lines = [[]]

  words.each do |word|
    if (line_length(lines.last) + word.length + 1) <= length
      lines.last << word
    else
      lines << [word]
    end
  end

  lines.map do |line|
    diff = length - line_length(line)
    [line, diff.zero? ? 1 : diff]
  end
end

def left_justify(scoring)
  buffer = +''
  scoring.each do |line|
    (words, spaces) = line
    buffer << words.join(' ') + (' ' * spaces) + "\n"
  end
  buffer
end

def right_justify(scoring)
  buffer = +''
  scoring.each do |line|
    (words, spaces) = line
    buffer << (' ' * spaces) + words.join(' ') + "\n"
  end
  buffer
end

def fully_justify(scoring, length)
  buffer = +''
  scoring.each do |line|
    (words, spaces) = line
    per_word = words.length == 2 ? spaces : (spaces.to_f / words.length).ceil
    tail = length - (words.sum(&:length) + (per_word * (words.length - 1)))
    words.each_with_index do |word, i|
      if i == words.length - 1
        buffer << (' ' * tail) + word
      else
        buffer << word + (' ' * per_word)
      end
    end
    buffer << "\n"
  end
  buffer
end

def line_length(words)
  words.join(' ').length
end

str = $stdin.read
l   = (ARGV[0] || 20).to_i

lines = score(str, l)
puts fully_justify(lines, l)
