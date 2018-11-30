module DashboardHelper

  def daily_collection_group_by_date
    @data = Hash.new
    today = Date.today
    week_start = today.at_beginning_of_week
    @daily_collections.select('date, SUM(total_price) as price').where(date: week_start..today).group(:date).each do |collection|
      @data.store(collection.date, collection.price)
    end

    @data
  end
end
