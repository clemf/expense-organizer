require 'spec_helper'

describe '#initialize' do
  it 'returns the variables of your expense' do
    test_expense = Expense.new({:description => "12 one sided bicycles", :amount => 54.31, :date => "2001-01-01", :id => nil})
    expect(test_expense.description).to(eq("12 one sided bicycles"))
    expect(test_expense.amount).to(eq(54.31))
    expect(test_expense.date).to(eq("2001-01-01"))
  end
end

describe '#save' do
  it 'saves the expense to the database' do
    test_expense = Expense.new({:description => "12 one sided bicycles", :amount => 54.31, :date => "2001-01-01", :id => nil})
    test_expense.save
    expect(Expense.all).to(eq([test_expense]))
  end
end

describe '.all' do
  it 'returns an empty array if the database is empty' do
    expect(Expense.all).to(eq([]))
  end
end

describe '#==' do
  it 'returns true if two expense objects have the same attributes' do
    test_expense = Expense.new({:description => "12 one sided bicycles", :amount => 54.31, :date => "2001-01-01", :id => nil})
    test_expense2 = Expense.new({:description => "12 one sided bicycles", :amount => 54.31, :date => "2001-01-01", :id => nil})
    expect(test_expense == test_expense2).to eq true
  end
end
