# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

users = User.create([
  {
    username: "admin",
    email: "admin@email.com",
    password_digest: "password",
  },
  {
    username: "user1",
    email: "user1@email.com",
    password_digest: "password",
  },
  {
    username: "user2",
    email: "user@email.com",
    password_digest: "password",
  }
])

posts = Post.create([
  {
    user: users[0],
    title: "Post 1",
    content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl vitae aliquam ultricies, nunc nisl ultricies nunc, vitae aliquam nisl nisl vitae nisl. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi.",
    slug: "post-1"
  },
  {
    user: users[1],
    title: "Post 2",
    content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl vitae aliquam ultricies, nunc nisl ultricies nunc, vitae aliquam nisl nisl vitae nisl. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi.",
    slug: "post-2"
  }
])

comments = Comment.create([
  {
    user: users[0],
    post: posts[0],
    content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl vitae aliquam ultricies, nunc nisl ultricies nunc, vitae aliquam nisl nisl vitae nisl. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi."
  },
  {
    user: users[1],
    post: posts[0],
    content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl vitae aliquam ultricies, nunc nisl ultricies nunc, vitae aliquam nisl nisl vitae nisl. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi."
  }
])

follows = Follow.create([
  {
    follower: users[0],
    followed: users[1]
  },
  {
    follower: users[1],
    followed: users[0]
  },
  {
    follower: users[2],
    followed: users[0]
  }
])

likes = Like.create([
  {
    user: users[0],
    likeable: posts[0]
  },
  {
    user: users[1],
    likeable: posts[0]
  },
  {
    user: users[2],
    likeable: comments[0]
  }
])

messages = Message.create([
  {
    sender: users[0],
    recipient: users[1],
    subject: "Message 1",
    content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl vitae aliquam ultricies, nunc nisl ultricies nunc, vitae aliquam nisl nisl vitae nisl. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi."
  },
  {
    sender: users[1],
    recipient: users[0],
    subject: "Message 2",
    content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl vitae aliquam ultricies, nunc nisl ultricies nunc, vitae aliquam nisl nisl vitae nisl. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi."
  }
])
