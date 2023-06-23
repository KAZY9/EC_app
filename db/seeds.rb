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
                    color: COLOR_LIST.sample,
                    brand: BRAND_LIST.sample,
                    shape: SHAPE.sample,
                    carrying_style: CARRYING_STYLE.sample,
                    style: STYLE.sample,
                    closure_method: CLOSURE_METHOD.sample
                )
    product.images.attach(io: File.open(Rails.root.join('app/assets/images/snowman01.webp')),
                        filename: 'snowman01.webp')
    product.images.attach(io: File.open(Rails.root.join('app/assets/images/snowman02.webp')),
                        filename: 'snowman02.webp')
    product.images.attach(io: File.open(Rails.root.join('app/assets/images/snowman03.webp')),
                        filename: 'snowman03.webp')              
end

#商品をお気に入りに追加
15.times do |i|
  Favorite.create!(
    user_id: 2,
    product_id: i + 1,
  )
end