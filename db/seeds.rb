# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password', username: 'admin')
Note.create(title: 'First note', kind: 'testing', content: 'Example content', url: nil, user_id: User.first.id)
Note.create(title: 'Second note', kind: 'testing', content: 'Example content #2', url: 'http://www.google.com', user_id: User.first.id)
tag_one = Tag.create(title: 'First tag')
tag_one.users << User.first
tag_one.notes << Note.first
tag_one.save
tag_two = Tag.create(title: 'Second tag')
tag_two.users << User.first
tag_two.notes << Note.first
tag_two.save
tag_three = Tag.create(title: 'Third tag')
tag_three.users << User.first
tag_three.notes << Note.last
tag_three.save
tag_four = Tag.create(title: 'Fourth tag')
tag_four.users << User.first
tag_four.notes << Note.last
tag_four.save
