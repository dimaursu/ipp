require_relative './my_classes.rb'
require 'yaml'

def build_items
  ingredients = YAML::load(File.open("ingredients.yml"))

  check_btns = []
  ingredients.each do |key, value|
    check_btns << MyLabel.new(key, value["max"])
    value["list"].each do |ingredient|
      check_btns << MyCheckButton.new(ingredient, key)
    end
  end
  check_btns
end

class PizzaAdriano < Gtk::Window
  def initialize(*args)
    super *args
    set_title  "Pizza Adriano"
    border_width = 10
    signal_connect('delete_event') { Gtk.main_quit }

    vbox = Gtk::VBox.new(false, 5)
    base_price = 40
    ### generation of underlaying buttons
    check_btns = build_items
    close  = Gtk::Button.new(Gtk::Stock::CLOSE)
    cost = Gtk::Label.new(base_price.to_s)
    valuta = Gtk::Label.new(" MDL")

    check_btns.each do |widget|
      widget.signal_connect('toggled') { |w| compute_cost(cost, w, check_btns) } if widget.is_a? MyCheckButton
    end
    close.signal_connect('clicked') { Gtk.main_quit }

    ### group buttons
    check_btns.each do |check|
      vbox.pack_start(check, false, true, 0)
    end

    hbox = Gtk::HBox.new()
    hbox.pack_start(cost, false)
    hbox.pack_start(valuta, false)
    vbox.pack_start(hbox, false, true, 0)
    vbox.pack_start(close,  false, true, 0)
    add(vbox)
    show_all
  end

  def compute_cost(cost_label, check_button, all_check_boxes)
    # change the cost of one pizza
    current_cost = Integer(cost_label.label)
    new_cost =  check_button.active? ? current_cost + check_button.price : current_cost - check_button.price
    cost_label.label = new_cost.to_s
    # disable all other buttons if the maximum of ingredients is reached
    tree = {}
    root = nil
    all_check_boxes.each do |row|
      if row.is_a? MyLabel
        tree[row] = []
        root = tree[row]
      else
        root << row
      end
    end
    tree.each do |key, value|
      max = key.max_ingredients
      toggled_widgets = value.select(&:active?)
      if max <= toggled_widgets.count
        # the the unticked widgets
        hide(value - toggled_widgets)
      else
        # enable all checkboxes
        unhide(value)
      end
    end
  end

  def hide(widgets)
    widgets.each { |w| w.sensitive = false }
  end

  def unhide(widgets)
    widgets.each { |w| w.sensitive = true }
  end
end

