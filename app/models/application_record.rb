class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  primary_abstract_class
  scope :latest, -> { order(created_at: :desc) }

   #都道府県コードから都道府県名に変換
   include JpPrefecture
   jp_prefecture :prefecture_code
          
   def prefecture_name
     JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
   end
          
   def prefecture_name=(prefecture_name)
     self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
   end
 
   def postal_code_with_mark
     "〒" + postal_code.to_s
   end
end
