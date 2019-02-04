require 'csv'

Book.destroy_all
Author.destroy_all
User.destroy_all

lines = CSV.new(File.open('./db/book-seeds.csv'), headers: true, header_converters: :symbol).read
lines.each do |line|
  line = line.to_h
  line[:authors] = [Author.find_or_create_by!(name: line[:author])]
  line.delete(:author)
  Book.create!(line)
end

user_1 = User.create(name: "ilovereading")
user_2 = User.create(name: "tomas_1999")
user_3 = User.create(name: "diego_marco")
user_4 = User.create(name: "joaquin_meteme")
user_5 = User.create(name: "inma_oteros")
user_6 = User.create(name: "de_marco_perez")
user_7 = User.create(name: "noone")
review_1 = Book.first.reviews.create(rating: 2, title: "Not the best", review_text: "It was an average book", user_id: user_1.id)
review_2 = Book.first.reviews.create(rating: 4, title: "Loved it", review_text: "Enjoyed every single page of it!", user_id: user_2.id)
review_3 = Book.second.reviews.create(rating: 5, title: "Pretty awesome", review_text: "Interesting all the way until the end", user_id: user_3.id)
review_4 = Book.third.reviews.create(rating: 5, title: "Best book ever", review_text: "Could not stop reading it", user_id: user_4.id)
review_5 = Book.third.reviews.create(rating: 3, title: "Average book", review_text: "I though it would be better", user_id: user_7.id)
review_6 = Book.fourth.reviews.create(rating: 1, title: "Super Boring", review_text: "Do not waste your time reading this book", user_id: user_5.id)
review_7 = Book.last.reviews.create(rating: 2, title: "Not what I expected", review_text: "Definitely not worth it", user_id: user_6.id)
