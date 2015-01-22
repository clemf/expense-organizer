class Expense
  attr_reader(:description, :amount, :date, :id)
  define_method :initialize do |attributes|
    @description = attributes.fetch(:description)
    @date = attributes.fetch(:date)
    @amount = attributes.fetch(:amount)
    @id = attributes.fetch(:id)
  end

  define_method :save do
    query = DB.exec("INSERT INTO expenses (description, amount, date) VALUES ('#{@description}', '#{@amount}', '#{@date}') RETURNING id;")
    @id = query[0]["id"].to_i
  end

  define_singleton_method :all do
    query = DB.exec("SELECT * FROM expenses;")
    all = []
    query.each() do |expenses|
      description = expenses.fetch("description")
      amount = expenses.fetch("amount").to_f
      date = expenses.fetch("date")
      id = expenses.fetch("id").to_i
      all.push(Expense.new({:description => description, :amount => amount, :date => date, :id => id}))
    end
    all
  end

  define_method :== do |another_expense|
    (self.description.==another_expense.description).&(self.date.==another_expense.date).&(self.amount.==another_expense.amount)
  end

  define_method :associate_category do |category|
    DB.exec("INSERT INTO expenses_categories (expense_id, category_id) VALUES (#{@id}, #{category.id});")
  end

  define_method :associated_category_ids do
    query = DB.exec(
    "SELECT c.id FROM
      categories c
    INNER JOIN
      expenses_categories ec
      ON c.id=ec.category_id
    INNER JOIN
      expenses e
      ON ec.expense_id=e.id
    WHERE e.id= #{@id};")
    output = []
    query.each() do |hash|
      output.push(hash["id"].to_i)
    end
    output
  end
end
