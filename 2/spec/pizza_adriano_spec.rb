require_relative './spec_helper.rb'
require 'gtk2'
require_relative '../checkbox.rb'

describe "Pizza Adriano" do
  it "should set the layout" do
    p = PizzaAdriano.new
    expect(p.hbox).to exis
  end
end
