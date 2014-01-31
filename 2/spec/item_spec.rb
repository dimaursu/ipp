require_relative './spec_helper.rb'
require 'gtk2'
require_relative '../checkbox.rb'

describe "Item" do
  it "should be a widget" do
    check_btns = build_items
    expect(check_btns.sample).to be_a(Gtk::Widget)
  end
  it "#hide" do
    widgets = [Gtk::CheckButton.new("sample"), Gtk::CheckButton.new("other")]
    pa = PizzaAdriano.new
    pa.hide(widgets)
    expect(widgets[0].sensitive?).to be_false
    expect(widgets[1].sensitive?).to be_false
  end
end
