class LocationValidator < ActiveModel::Validator

  def validate(record)
    if !record.origin.empty? && !record.get_google_api.nil?
      if record.get_google_api[:status] == "NOT_FOUND"
        record.errors[:origin] << "is not found"
      end
    end

    if !record.destination.empty? && !record.get_google_api.nil?
      if record.get_google_api[:status] == "NOT_FOUND"
        record.errors[:destination] << "is not found"
      end
    end
  end
  
  
end