# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

3.times do |i|
  user_number = format('%03d', i + 1)  # 001, 002, 003を作成
  User.find_or_create_by(email: "user#{user_number}@test.com") do |user|
    user.password = "test1234"
  end

  50.times do |j|
    article_number = j + 1
    Article.find_or_create_by(title: "No.#{article_number}: user#{user_number}の記事") do |article|
      article.content = "No.#{article_number}: user#{user_number}の記事の本文"
      article.user_id = User.find_by(email: "user#{user_number}@test.com").id
    end
  end
end