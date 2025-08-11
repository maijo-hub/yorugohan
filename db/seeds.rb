# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "seedの実行を開始"

Admin.find_or_create_by!(email: "admin@example.com") do |admin|
 admin.password= "password"
end

puts "admin登録完了"

user_attributes = [
  {
    username: "yamada",
    profile: "よろしくお願いします"
  },
  {
    username: "tanaka",
    profile: "よろしく"
  },
  {
    username: "olivia",
    profile: "hello"
  },
  {
    username: "james",
    profile: "good evening"
  },
  {
    username: "lucas",
    profile: "ラーメン大好き"
  }
]

puts "user登録開始"
user_attributes.each.with_index(1) do |attribute, i|
  User.find_or_create_by!(email: "user_#{i}@test.com") do |user|
    user.username = attribute[:username]
    user.profile = attribute[:profile]
    user.password = "password"
  end
end

recipe_attributes = [
  {
    title: "チーズたっぷりハンバーグ",                                      
    description:"【カマンベールチーズハンバーグ】\r\n［材料］4人前\r\n◾️ハンバーグのタネ\r\n合い挽きミンチ　300g\r\n塩　小さじ1/2\r\n胡椒　少々\r\nナツメグ　少々\r\n玉ねぎ（みじん切り）1/2個\r\n卵　1個\r\n麩　20g\r\n牛乳　80cc\r\n\r\nカマンベールチーズ　1/2個",
    image: "#{Rails.root}/db/fixtures/sample-post1.jpg"
  }
]

recipe_attributes.each do |attribute|
  Recipe.find_or_create_by!(title: attribute[:title]) do |recipe|
    recipe.description = attribute[:description]
    recipe.image = ActiveStorage::Blob.create_and_upload!(io: File.open(attribute[:image]), filename:"sample-post3.jpg")
    recipe.user_id = User.all.sample.id
  end
end
puts "レシピ登録完了"


puts "seedの実行が完了しました"
