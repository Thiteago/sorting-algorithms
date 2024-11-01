module SortingAlgorithms
  def self.bubble_sort(array)
    n = array.size
    loop do
      swapped = false
      (n - 1).times do |i|
        if array[i] > array[i + 1]
          array[i], array[i + 1] = array[i + 1], array[i]
          swapped = true
        end
      end
      break unless swapped
    end
    array
  end

  def self.quick_sort(array)
    return array if array.size <= 1
    pivot = array.delete_at(rand(array.size))
    left, right = array.partition { |x| x < pivot }
    quick_sort(left) + [pivot] + quick_sort(right)
  end

  def self.merge_sort(array)
    return array if array.size <= 1
    mid = array.size / 2
    left = merge_sort(array[0...mid])
    right = merge_sort(array[mid..-1])
    merge(left, right)
  end

  def self.merge(left, right)
    sorted = []
    until left.empty? || right.empty?
      sorted << (left.first <= right.first ? left.shift : right.shift)
    end
    sorted + left + right
  end
end
