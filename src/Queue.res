type t<'item> = {mutable items: array<'item>, maxSize: int}

/**
 Creates a new queue with a maximum size.
 */
let make = (maxSize: int) => {
  {items: [], maxSize}
}

/**
 Adds an item to the queue.
 If the queue is full, the oldest item is removed.
 */
let enqueue = (t: t<'item>, item: 'item) => {
  t.items->Array.push(item)
  if t.items->Array.length > t.maxSize {
    t.items->Array.shift->ignore
  }
}

/**
 Removes and returns the oldest item from the queue.
 */
let dequeue = (t: t<'item>) => {
  t.items->Array.shift
}

/**
 Returns the oldest item from the queue without removing it.
 */
let peek = (t: t<'item>) => {
  t.items[0]
}
