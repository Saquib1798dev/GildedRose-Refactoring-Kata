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
      if [AGED, BACKSTAGE].include?(item.name)
        if item.quality < 50
          item.quality += 1
          #checks for name
          item = increment_quality_for_backstage(item) if item.name == BACKSTAGE
        end
        #checking of exceptions
      else
        #decreasing quality of items, other than following
        decrease_quality_for_items(item)
      end
      #decrease the days
      update_item_sell_in(item)
      sell_in_lesser_than_zero(item) if item.sell_in < 0
    end
  end

  private

  def increment_quality_for_backstage(item)
    item.quality += 1 if item.sell_in < 11 and item.quality < 50
    item.quality += 1 if item.sell_in < 6 and item.quality < 50
    item
  end

  def decrease_quality_for_items(item)
    if item.quality > 0
      item.quality -= 1 if item.name != SULFUR
      #double decrease in quality
      if item.name == CONJOUR
        item.quality -= 1 if  item.quality >= 1
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
      item.quality += 1 if item.quality < 50
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
