require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  #Here the quality of item will never be negative as it has been mentioned in the document

  describe "#update_quality" do
    context "when name is not changed" do
      it "does not change the name" do
        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].name).to eq "foo"
      end
    end

    context "when the item is Aged Brie" do
      #it gets better as it gets older
      before do
        @items = [
          Item.new("Aged Brie", 4, 8),
          Item.new("Aged Brie", 3, 9),
          Item.new("Aged Brie", -2, 8),
          Item.new("Aged Brie", -3, 4),
          Item.new("Aged Brie", -3, 54)
        ]
        GildedRose.new(@items).update_quality()
      end

      it "should have quality equal to specific increased quality" do
        expect(@items[0].quality).to eq(9)
        expect(@items[1].quality).to eq(10)
        expect(@items[2].quality).to eq(10)
        expect(@items[3].quality).to eq(6)
      end

      it 'should give the same quality as the quality is creater than 50' do
        expect(@items[4].quality).to eq(54)
      end
    end

    context "when the item is Elixir of the Mongoose" do
      before do
        @items = [
          Item.new("Elixir of the Mongoose", 4, 7),
          Item.new("Elixir of the Mongoose", 1, 6),
          Item.new("Elixir of the Mongoose", -2, 9),
          Item.new("Elixir of the Mongoose", -4, 1)
        ]
        GildedRose.new(@items).update_quality()
      end

      it 'should have quality equal to give quality' do
        expect(@items[0].quality).to eq(6)
        expect(@items[1].quality).to eq(5)
        expect(@items[2].quality).to eq(7)
        expect(@items[3].quality).to eq(0)
      end

    end

    #quality is never altered
    context "when the item is Sulfuras, Hand of Ragnaros" do
      before do
        @items = [
          Item.new("Sulfuras, Hand of Ragnaros", 3, 80),
          Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
          Item.new("Sulfuras, Hand of Ragnaros", -3, 80),
          Item.new("Sulfuras, Hand of Ragnaros", -5, 80),
          Item.new("Sulfuras, Hand of Ragnaros", -3, 80)
        ]
        GildedRose.new(@items).update_quality()
      end

      it 'should have quality equal to give quality and here the quality is unchanged' do
        expect(@items[0].quality).to eq(80)
        expect(@items[1].quality).to eq(80)
        expect(@items[2].quality).to eq(80)
        expect(@items[3].quality).to eq(80)
      end

    end

    context "when the item is Backstage passes to a TAFKAL80ETC concert" do 
      before do
        @items = [
          Item.new("Backstage passes to a TAFKAL80ETC concert", 3, 6),
          Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 5),
          Item.new("Backstage passes to a TAFKAL80ETC concert", -3, 8),
          Item.new("Backstage passes to a TAFKAL80ETC concert", -5, 0),
          Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 5),
          Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 6)
        ]
        GildedRose.new(@items).update_quality()
      end

      it 'should have quality equal to give quality' do
        expect(@items[0].quality).to eq(9)
        expect(@items[1].quality).to eq(0)
        expect(@items[2].quality).to eq(0)
        expect(@items[3].quality).to eq(0)
      end

      it 'should increase quality by when there are 10 days or less' do
        expect(@items[4].quality).to eq(7)
      end

      it 'should increase quality by when there are 5 days or less' do
        expect(@items[5].quality).to eq(9)
      end

    end

    context "when the item is Conjured Mana Cake " do
      before do
        @items = [
          Item.new("Conjured Mana Cake", 4, 6),
          Item.new("Conjured Mana Cake", 6, 15),
          Item.new("Conjured Mana Cake", 13, 18),
          Item.new("Conjured Mana Cake", 15, 10),
          Item.new("Conjured Mana Cake", 15, 49),
          Item.new("Conjured Mana Cake", 15, 52)
        ]
        GildedRose.new(@items).update_quality()
      end

      it 'should have quality equal to give quality' do
        expect(@items[0].quality).to eq(4)
        expect(@items[1].quality).to eq(13)
        expect(@items[2].quality).to eq(16)
        expect(@items[3].quality).to eq(8)
        expect(@items[4].quality).to eq(47)
      end

      it "should have when quality greater than 50 " do
        expect(@items[5].quality).to eq(50)
      end
    end
  end

end
