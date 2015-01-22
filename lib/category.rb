class Category
  attr_reader(:name, :monthly_budget, :id)
  define_method :initialize do |attributes|
    @name = attributes.fetch(:name)
    @monthly_budget = attributes.fetch(:monthly_budget)
    @id = attributes.fetch(:id)
  end

  define_method :save do
    query = DB.exec("INSERT INTO categories (name, monthly_budget) VALUES ('#{@name}', #{@monthly_budget}) RETURNING id;")
    @id = query[0]["id"].to_i
  end

  define_singleton_method :all do
    query = DB.exec("SELECT * FROM categories;")
    all = []
    query.each() do |category|
      name = category.fetch("name")
      monthly_budget = category.fetch('monthly_budget').to_f
      id = category.fetch('id').to_i
      all.push(Category.new({:name => name, :monthly_budget => monthly_budget, :id => id}))
    end
    all
  end

  define_method :== do |another_category|
    (self.name.==another_category.name).&(self.monthly_budget.==another_category.monthly_budget)
  end

  define_method :associated_expense_ids do
    query = DB.exec(
    "SELECT e.id FROM
      expenses e
    INNER JOIN
      expenses_categories ec
      ON e.id=ec.expense_id
    INNER JOIN
      categories c
      ON ec.category_id=c.id
    WHERE c.id= #{@id};")
    output = []
    query.each() do |hash|
      output.push(hash["id"].to_i)
    end
    output
  end
end
