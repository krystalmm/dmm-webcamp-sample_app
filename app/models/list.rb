class List < ApplicationRecord
  # Refile（画像投稿機能）を使うためにattachmentメソッドを追加！
  # カラム名はimage_idだが、ここでは_idはつけない！！
  attachment :image
end

