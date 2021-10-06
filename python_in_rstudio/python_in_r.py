import pandas as pd

users = pd.read_table(
  "https://raw.githubusercontent.com/wesm/pydata-book/2nd-edition/datasets/movielens/users.dat", 
  sep="::", 
  header=None,
  names=["user_id", "gender", "age", "occupation", "zip"]
)

# movies = pd.read_table(
#   "https://raw.githubusercontent.com/wesm/pydata-book/2nd-edition/datasets/movielens/movies.dat", 
#   sep="::", 
#   header=None,
#   names=["movie_id", "title", "genres"]
# )

ratings = pd.read_table(
  "https://raw.githubusercontent.com/wesm/pydata-book/2nd-edition/datasets/movielens/ratings.dat", 
  sep="::", 
  header=None,
  names=["user_id", "movie_id", "rating", "timestamp"]
)

df = pd.merge(ratings, users)

df.pivot_table(values="rating", index="movie_id", columns="gender")
