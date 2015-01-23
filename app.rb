require('sinatra')
require('sinatra/reloader')
also_reload('./lib/**/*.rb')
require('./lib/category')
require('./lib/expense')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'expense_organizer'})

get '/' do
  @expenses = Expense.all
  @categories = Category.all
  erb(:expenses_home)
end

post '/add_expense' do
  @description = params.fetch("description")
  @amount = params.fetch('amount')
  @date = params.fetch('date')
  @new_expense = Expense.new({:description => @description, :amount => @amount, :date => @date, :id => nil})
  @new_expense.save()
  redirect '/'
end

post '/associate_category' do
  @category_id = params.fetch('category_id')
  @expense = Expense.get_expense(params.fetch('expense_id').to_i)
  if @category_id != nil
    @expense.associate_category(@category_id)
  end
  redirect '/'
end
