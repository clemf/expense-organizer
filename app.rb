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
