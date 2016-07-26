require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.get(key)
      link = @map.get(key)
      update_link!(link)
      link.val
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    @map.set(key, @store.insert(key, val))
    eject! if count > @max
    val
  end

  def update_link!(link)
    link.prev.next = link.next
    link.next.prev = link.prev
    link.prev = @store.last
    link.next = @store.last.next
    @store.last.next = link
  end

  def eject!
    old_link = @store.first
    @store.remove(old_link.key)
    @map.delete(old_link.key)
  end
end
