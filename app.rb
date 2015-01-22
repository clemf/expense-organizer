require('sinatra')
require('sinatra/reloader')
require('./lib/category')
require('./lib/expense')
require('pg')

DB = PG.connect({:dbname => 'expense_organizer'})

get '/' do
  @expenses = Expense.all
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
