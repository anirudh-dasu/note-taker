# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[User, UserDevice, Note, Tag].each(&:delete_all)

User.populate(5) do |user|
  user.email = Faker::Internet.email
  user.username = Faker::Name.name
  user.password_digest = User.new(password: 'password').password_digest

  Note.populate(10) do |note|
    note.title = Faker::Movie.quote
    note.content = Populator.sentences(5)
    note.kind = Faker::Color.color_name

    Tag.populate(10) do |tag|
      tag.title = Faker::LordOfTheRings.character
    end
  end

end

User.all.each do |user|
  device = UserDevice.create(device_type: 'chrome', device_id: UUID.new.generate, user_id: user.id)
  device.generate_jwt_token!
  device.save
end

Note.all.each do |note|
  note.user_id = User.order("RANDOM()").first.id
  note.save
  tags = Tag.order("RANDOM()").limit(5)
  note.tags << tags
  note.user.tags << tags
end
