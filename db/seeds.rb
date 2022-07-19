# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Post.destroy_all
Comment.destroy_all
Faker::UniqueGenerator.clear
NUM_POST = 50

NUM_POST.times do
  created_at = Faker::Date.backward(days:365 * 5)
  post = Post.new(
    title: Faker::Hacker.unique.say_something_smart,
    body: Faker::ChuckNorris.fact,
    created_at: created_at,
    updated_at: created_at,
  )
  post.save
  if post.valid?
    rand(1..5).times do
      comment_time = Faker::Date.backward(days:365 * 5)
      comment = Comment.new(
        body: Faker::Hacker.say_something_smart,
        created_at: comment_time,
        updated_at: comment_time,
      )
      comment.post = post
      comment.save
    end
  end
end

posts = Post.all
comments = Comment.all

puts Cowsay.say("Generated #{posts.count} posts, #{comments.count} comments", :koala)
