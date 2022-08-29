puts "Hello Bubble Sort Problem"

=begin   

    Build a method #bubble_sort that takes an array and returns a sorted
    array. It must use the bubble sort methodology (using #sort would be
    pretty pointless, wouldn’t it?).

    > bubble_sort([4,3,78,2,0,2])
    => [0,2,2,3,4,78]
=end

def bubble_sort(array)


    temp = 0
    sorted = true

    for i in 0..array.length
        sorted = true
        for j in 0..array.length-2
            #print "\narray[j] is: #{array[j]}, j+1 is: #{array[j+1]}\n"
            if array[j] > array[j+1]
                temp = array[j]
                array[j] = array[j+1]
                array[j+1] = temp
                sorted = false
            end
            #print "\nArray is: #{array}\n"
        end
        break if sorted
    end

    #print "Array is: #{array}"
    return array
end

t1 = [4,3,78,2,0,2]
t2 = [-99, -100, 2, 55, 6, -1000]
t3 = [66, -4, 5, 1, 0, 0, 77, 77, 24, 2, 5, -8]

p bubble_sort(t1)
p bubble_sort(t2)
p bubble_sort(t3)

