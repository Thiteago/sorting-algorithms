require 'csv'

def generate_samples
  sample_sizes = (1..10).map { |i| i * 10_000 }
  samples = sample_sizes.map do |size|
    Array.new(size) { rand(1..100_000) }
  end

  File.open('samples.txt', 'w') do |file|
    samples.each { |sample| file.puts(sample.join(',')) }
  end

  samples
end
