FactoryBot.define do
    factory :user do
        username {'山田太郎'}
        username_kana {'ヤマダタロウ'} 
        postal_code {'1008111'}  
        street_and_others {'1-1'}
        tel {'08012345678'}
        email {'test1@example.com'}
        password {'pass01@!'}
        password_confirmation {'pass01@!'}
        birthday {'2000-01-01'}
        sex {'男性'}
        job {'公務員'}
    end
end