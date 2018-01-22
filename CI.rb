class Employee
  attr_reader :salary
  def initialize(name='John Doe', title='Worker', salary=20_000, boss = 'Jefe')
    @name = name
    @title= title
    @salary = salary
    @boss = boss    
  end
  
  def bonus(multiplier)
    self.salary * multiplier
  end
end

class Manager < Employee
  attr_reader :employees
  def initialize()
    super
    @employees = []
    @name = "Jane Doe"
    @salary = 50_000
  end
  
  def bonus(multiplier)
    self.employees.map {|el| el.salary}.reduce(:+) * multiplier
  end
  
  
end