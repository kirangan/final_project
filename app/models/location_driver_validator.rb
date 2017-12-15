class LocationDriverValidator < ActiveModel::Validator

  def validate(record)
    if !record.location.empty? && !record.get_google_api.nil?
      if record.get_google_api[:status] == "NOT_FOUND"
        record.errors[:location] << "is not found"
      end
    end
  end 
end