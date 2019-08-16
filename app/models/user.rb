class User < ApplicationRecord
  require 'csv'
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  def self.import(file)
    return nil if file.nil?
    CSV.foreach(file.path, headers: true) do |row|

      user = User.new({customer_name: row.to_hash["Customer Name"],
                       item_description: row.to_hash["Item Description"],
                       item_price: row.to_hash["Item Price"],
                       quantity: row.to_hash["Quantity"],
                       merchant_name: row.to_hash["Merchant Name"],
                       merchant_address: row.to_hash["Merchant Address"]})

      if user.valid?
        puts "Created #{user.customer_name}"
        user.save!
      end
    end
  end

  def self.get_total_sales
    User.all.sum(:item_price)
  end
end

