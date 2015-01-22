require 'spec_helper'

describe '#initialize' do
  it 'returns the variables of your category' do
    test_category = Category.new({:name => "Fun", :monthly_budget => 54.31, :id => nil})
    expect(test_category.name).to(eq("Fun"))
    expect(test_category.monthly_budget).to(eq(54.31))
  end
end

describe '#save' do
  it 'saves the category to the database' do
    test_category = Category.new({:name => "Fun", :monthly_budget => 54.31, :id => nil})
    test_category.save
    expect(Category.all).to(eq([test_category]))
  end
end

describe '.all' do
  it 'returns an empty array if the database is empty' do
    expect(Category.all).to(eq([]))
  end
end

describe '#==' do
  it 'returns true if two category objects have the same attributes' do
    test_category = Category.new({:name => "Fun", :monthly_budget => 54.31, :id => nil})
    test_category2 = Category.new({:name => "Fun", :monthly_budget => 54.31, :id => nil})
    expect(test_category == test_category2).to eq true
  end
end

describe '#associated_expense_ids' do
  it 'lists all expenses associated with the category' do
    test_category = Category.new({:name => "Fun", :monthly_budget => 54.31, :id => nil})
    test_category.save
    test_expense = Expense.new({:description => "12 one sided bicycles", :amount => 54.31, :date => "2001-01-01", :id => nil})
    test_expense.save
    test_expense.associate_category(test_category.id)
    expect(test_category.associated_expense_ids).to eq [test_expense.id]
  end
end

describe '#get_category' do
  it 'takes an id and returns the category' do
    test_category = Category.new({:name => "Fun", :monthly_budget => 54.31, :id => nil})
    test_category.save
    expect(Category.get_category(test_category.id)).to eq test_category
  end
end
