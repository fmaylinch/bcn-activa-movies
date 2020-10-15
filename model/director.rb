class Director

  attr_reader :id, :name, :country

  def initialize(id, name, country)
    @id = id
    @name = name
    @country = country
  end
end

class DirectorsStore

  def all

    # https://www.rubyguides.com/2015/05/working-with-files-ruby/
    lines = File.readlines("db/directors.csv").map(&:chomp)

    lines.map do |line|
      (id, name, country) = line.split(",")
      Director.new(id.to_i, name, country)
    end
  end
end