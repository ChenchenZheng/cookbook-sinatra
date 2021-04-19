class Recipe
  attr_reader :name, :description, :rating, :prep_time
  attr_writer :done

  def initialize(name, description, rating, prep_time, done)
    @name = name
    @description = description
    @rating = rating
    @prep_time = prep_time
    @done = done == 'true'
  end

  def done!
    @done = true
  end

  def done?
    @done
  end
end
