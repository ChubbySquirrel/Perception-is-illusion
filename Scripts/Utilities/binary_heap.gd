# MinBinaryHeap.gd
class_name MinBinaryHeap  # optional, allows `MinBinaryHeap.new()` elsewhere

var heap: Array = []

func size() -> int:
	return heap.size()

func is_empty() -> bool:
	return heap.is_empty()

func push(value, priority: float) -> void:
	var node = {"value": value, "priority": priority}
	heap.append(node)
	_heapify_up(heap.size() - 1)

func pop():
	if is_empty():
		return null
	var root = heap[0]["value"]
	heap[0] = heap[-1]
	heap.pop_back()
	_heapify_down(0)
	return root

func peek():
	return heap[0]["value"] if not is_empty() else null

func _heapify_up(index: int) -> void:
	while index > 0:
		var parent = (index - 1) / 2
		if heap[index]["priority"] < heap[parent]["priority"]:
			_swap(index, parent)
			index = parent
		else:
			break

func _heapify_down(index: int) -> void:
	var heap_size = heap.size()
	while index < heap_size:
		var left = 2 * index + 1
		var right = 2 * index + 2
		var smallest = index

		if left < heap_size and heap[left]["priority"] < heap[smallest]["priority"]:
			smallest = left
		if right < heap_size and heap[right]["priority"] < heap[smallest]["priority"]:
			smallest = right

		if smallest != index:
			_swap(index, smallest)
			index = smallest
		else:
			break

func _swap(index1,index2):
	var temp = heap[index1]
	heap[index1] = heap[index2]
	heap[index2] = temp

func peek_priority():
	return heap[0]["priority"] if not is_empty() else null
