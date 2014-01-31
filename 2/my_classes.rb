class MyCheckButton < Gtk::CheckButton
  attr_reader :price, :type
  def initialize(ingredient, type)
    super ingredient.join(" ")
    @price = ingredient[1]
    @type = type
  end
end

class MyLabel < Gtk::Label
  #this is actually a ingredient category
  attr_reader :max_ingredients
  def initialize(text, max)
    super text
    @max_ingredients = max
  end
end

