# DB

## usersテーブル

|Column|Type|Option|
|------|----|------|
|nickname|string|null: false|
|mail|string|null: false, unique: true|
|password|string|null: false|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthday|date|null: false|

### Association

- has_one :address, dependent: :destroy
- has_many :credit_cards, dependent: :destroy
- has_many :items, dependent: :destroy
- has_many :buyings, dependent: :destroy

## addressesテーブル

|Column|Type|Option|
|------|----|------|
|user_id|integer|null: false, foreign_key: true|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|postal_code|string|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|block|string|null: false|
|building|string||
|phone|string||

### Association

- belongs_to :user
- has_many :buyings

## credit_cardsテーブル

|Column|Type|Option|
|------|----|------|
|user_id|integer|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|

### Association

- belongs_to :user
- has_many :buyings

## buyingsテーブル

|Column|Type|Option|
|------|----|------|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
|address_id|integer|null: false, foreign_key: true|
|credit_card_id|integer|null: false, foreign_key: true|
|amount|integer|null: false|

### Association

- belongs_to :user
- belongs_to :address
- belongs_to :credit_card
- belongs_to :item

## itemsテーブル

|Column|Type|Option|
|------|----|------|
|user_id|integer|null: false, foreign_key: true|
|name|string|null: false|
|description|text|null: false|
|category_id|integer|null: false, foreign_key: true|
|brand_id|integer|foreign_key: true|
|condition_id|integer|null: false|
|postage_payment_id|integer|null: false|
|ship_from_id|integer|null: false|
|preparation_id|integer|null: false|
|price|integer|null: false|
|status_id|integer|null: false|
|size|string||

### Association

- belongs_to :user
- has_one :buying, dependent: :destroy
- has_many :images, dependent: :destroy
- belongs_to :category
- belongs_to :brand

## imagesテーブル

|Column|Type|Option|
|------|----|------|
|item_id|integer|null: false, foreign_key: true|
|picture|string|null: false|

### Association

- belongs_to :item

## categoriesテーブル

|Column|Type|Option|
|------|----|------|
|name|string|null: false|
|ancestry|string|

### Association

- has_many :items
- has_ancestry

## brandsテーブル

|Column|Type|Option|
|------|----|------|
|name|string|null: false|

### Association

- has_many :items
