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
users = []

user_attributes.each.with_index(1) do |attribute, i|
  user = User.find_or_create_by!(email: "user_#{i}@test.com") do |user|
    user.username = attribute[:username]
    user.profile = attribute[:profile]
    user.password = "password"
  end
  users << user
end

recipe_attributes = [
  {
    title: "チーズおかかおにぎり",                                      
    description:"【チーズおかかおにぎり】\r\n［材料］\r\nご飯　1膳\r\nスライスチーズ　1枚\r\nおかか昆布　適量\r\n塩　少々",
    image: "#{Rails.root}/db/fixtures/sample-post1.jpg",
    user_id: users[0].id 
  },
  {
    title: "チーズハンバーグ",                                      
    description:"【カマンベールチーズハンバーグ】\r\n［材料］4人前\r\n◾️ハンバーグのタネ\r\n合い挽きミンチ　300g\r\n塩　小さじ1/2\r\n胡椒　少々\r\nナツメグ　少々\r\n玉ねぎ（みじん切り）1/2個\r\n卵　1個\r\n麩　20g\r\n牛乳　80cc\r\n\r\nカマンベールチーズ　1/2個",
    image: "#{Rails.root}/db/fixtures/sample-post2.jpg",
    user_id: users[1].id 
  },
  {
    title: "きなこヨーグルト",                                      
    description:"【きなこヨーグルト】\r\n［材料］\r\nヨーグルト　100g\r\nきなこ　20g",
    image: "#{Rails.root}/db/fixtures/sample-post1.jpg",
    user_id: users[0].id 
  },
  {
    title: "コーンスープ",                                      
    description:"【コーンスープ】\r\n［材料］1人前\r\nコーンスープのもと　1袋\r\nお湯　150mL",
    image: "#{Rails.root}/db/fixtures/sample-post2.jpg",
    user_id: users[1].id 
  },
  {
    title: "バターコーン",                                      
    description:"【バターコーン】\r\n［材料］\r\nコーンの缶詰　1缶\r\nバター　10g\r\n醤油　少々",
    image: "#{Rails.root}/db/fixtures/sample-post2.jpg",
    user_id: users[1].id 
  },
  {
    title: "きのこソテー",                                      
    description:"【きのこソテー】\r\n［材料］4人前\r\nしめじ　1袋\r\n舞茸　1袋\r\nオリーブオイル　大さじ1\r\n醤油　小さじ1",
    image: "#{Rails.root}/db/fixtures/sample-post3.jpg",
    user_id: users[2].id 
  },
  {
    title: "鳥の照り焼き　2食丼",                                      
    description:"【鳥の照り焼き　2食丼】\r\n［材料］\r\n鶏もも　1枚\r\n醤油　酒　みりん　砂糖各大さじ2\r\nサラダ油　少々\r\n卵　2個\r\n塩　少々",
    image: "#{Rails.root}/db/fixtures/sample-post3.jpg",
    user_id: users[2].id 
  }, {
    title: "チキンステーキ",                                      
    description:"【チキンソテー　ポテト添え】\r\n［材料］\r\n鶏もも　1枚\r\n塩　3g\r\n冷凍フライドポテト　適量",
    image: "#{Rails.root}/db/fixtures/sample-post4.jpg",
    user_id: users[3].id 
  }, {
    title: "味噌汁",                                      
    description:"【大根の味噌汁】\r\n［材料］\r\n大根　5cm\r\n味噌　適量\r\n水　450mL\r\n出汁パック　1枚",
    image: "#{Rails.root}/db/fixtures/sample-post4.jpg",
    user_id: users[3].id 
  }
]

recipe_attributes.each do |attribute|
  Recipe.find_or_create_by!(title: attribute[:title]) do |recipe|
    recipe.description = attribute[:description]
    recipe.image = ActiveStorage::Blob.create_and_upload!(io: File.open(attribute[:image]), filename:"sample-post3.jpg")
    recipe.user_id = attribute[:user_id]
  end
end
puts "レシピ登録完了"


puts "seedの実行が完了しました"
