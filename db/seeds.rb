#管理者ユーザーを作成
#管理者ユーザーでは、商品の追加、編集、削除が可能でず。
#emailは自分のを入力してください。rails db:seedを実行したら設定したメールアドレスにメールが送られるのでそのメールから有効化してください。
User.create!(
    username: "管理者",
    postal_code: "1008111",
    prefecture_code: "東京都",
    city: "千代田区千代田",
    street_and_others: "１－１宮内庁",
    tel: "08011112222",
    email: "kazu.m.sora9@gmail.com",
    password: "Passw0rd1!",
    password_confirmation: "Passw0rd1!",
    agreement: true,
    admin: true
  )

User.create!(
  username: "山田太郎",
  postal_code: "1008111",
  prefecture_code: "東京都",
  city: "千代田区千代田",
  street_and_others: "１－１宮内庁",
  tel: "08011112222",
  email: "gi09ty01@gmail.com",
  password: "Passw0rd1!",
  password_confirmation: "Passw0rd1!",
  agreement: true,
  admin: false
)


#商品データを追加
50.times do |i|
    product = Product.create!(
                    name: "商品" + (1 + i).to_s,
                    price: Faker::Number.between(from: 5000, to: 50000),
                    description: Faker::Lorem.sentence,
                    stock: Faker::Number.between(from: 1, to: 20),
                    color: Faker::Color.color_name
                )
    
    filenames = ['snowman01.webp', 'snowman02.webp', 'snowman03.webp']
    filenames.each do |filename|
      product.images.attach(io: File.open(Rails.root.join('app/assets/images', filename)), filename: filename)
    end
end