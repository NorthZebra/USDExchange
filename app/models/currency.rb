class Currency < ActiveRecord::Base
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Currency.create! row.to_hash
      
    end
  end 
end
