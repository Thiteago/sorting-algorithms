require './SortingAlgorithms/sort.rb'
require './generate_samples.rb'
require 'gruff'

def run_sorting_algorithms(samples)
  puts "Running sorting algorithms..."
  results = []
  algorithms = {
    # "BubbleSort" => SortingAlgorithms.method(:bubble_sort),
    "QuickSort" => SortingAlgorithms.method(:quick_sort),
    "MergeSort" => SortingAlgorithms.method(:merge_sort)
  }

  algorithms.each do |name, sort_method|
    samples.each_with_index do |sample, index|
      puts 'Running ' + name + ' with sample size ' + (index + 1).to_s
      thread = Thread.new do
        array_copy = sample.dup
        start_time = Time.now
        sort_method.call(array_copy)
        end_time = Time.now
        elapsed_time = end_time - start_time
        results << [name, (index + 1) * 10_000, elapsed_time]
      end
      thread.join
    end
  end

  results
end

def save_results_to_csv(results)
  puts "Saving results to CSV..."
  CSV.open('results.csv', 'w') do |csv|
    csv << ["Algorithm", "Sample Size", "Execution Time (s)"]
    results.each do |result|
      csv << result
    end
  end
end

def plot_results
  puts "Plotting results..."
  data = CSV.read('results.csv', headers: true)
  sample_sizes = data['Sample Size'].uniq.map(&:to_i).sort

  g = Gruff::Line.new
  g.title = 'Sorting Algorithm Performance'
  g.labels = sample_sizes.map.with_index { |size, i| [i, size.to_s] }.to_h

  %w[QuickSort MergeSort].each do |algorithm|
    puts 'Plotting ' + algorithm
    times = data.select { |row| row['Algorithm'] == algorithm }.map { |row| row['Execution Time (s)'].to_f }
    g.data(algorithm, times)
  end

  g.write('performance_chart.png')
end


def main
  samples = generate_samples
  results = run_sorting_algorithms(samples)
  save_results_to_csv(results)
  plot_results
end

main
