class GildedRose
  AGED = "Aged Brie" 
  BACKSTAGE = "Backstage passes to a TAFKAL80ETC concert"
  SULFUR = "Sulfuras, Hand of Ragnaros"
  CONJOUR = "Conjured Mana Cake"

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name != AGED and item.name != BACKSTAGE
        #decreasing quality of items, other than following
        decrease_quality_for_items(item)
      else
        #checking of exceptions
        if item.quality < 50
          item.quality = item.quality + 1
          #checks for name
          if item.name == BACKSTAGE
            item = increment_quality_for_backstage(item)
          end
        end
      end
      #decrease the days
      update_item_sell_in(item)
      if item.sell_in < 0
        sell_in_lesser_than_zero(item)
      end
    end
  end

  private

  def increment_quality_for_backstage(item)
    item.quality = item.quality + 1 if item.sell_in < 11 and item.quality < 50
    item.quality = item.quality + 1 if item.sell_in < 6 and item.quality < 50
    item
  end

  def decrease_quality_for_items(item)
    if item.quality > 0
      item.quality = item.quality - 1 if item.name != SULFUR
      #double decrease in quality
      if item.name == CONJOUR
        item.quality = item.quality - 1 if  item.quality >= 1
      end 
    end
    item
  end

  def update_item_sell_in(item)
    if item.name == SULFUR
      item
    else
      item.sell_in -= 1
    end
    item
  end

  def sell_in_lesser_than_zero(item)
    if item.name != AGED
      if item.name != BACKSTAGE
        #quantity decreasing
        item = decrease_quality_for_items(item)
      else
        item.quality = item.quality - item.quality
      end
    else
      item.quality = item.quality + 1 if item.quality < 50
    end
    item
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
