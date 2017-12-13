class GopayValidator < ActiveModel::Validator
  def validate(record)
    if record.payment == "Go-Pay"
      gopay = User.find(record.user_id).gopay
      if !record.total_price.nil?
        if gopay < record.total_price
          record.errors[:payment] << "Go-Pay credit is not enough"
        end
      end


      # if record.total_price.nil?
      #   if gopay < record.sub_total
      #     record.errors[:payment] << "Go-Pay credit is not enough"
      #   end
      # elsif !record.total_price.nil?
      #   if gopay < record.total_price
      #     record.errors[:payment] << "Go-Pay credit is not enough"
      #   end
      # end
    end
  end
  
  
end