movies = [
    {name: 'Memento', director: 'Nolan', rating: 10},
    {name: 'Pulp Fiction', director: 'Tarantino', rating: 9}
]

movies.each do |m|
  Movie.create(m)
end
