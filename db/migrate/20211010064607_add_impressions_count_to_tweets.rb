class AddImpressionsCountToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :impressions_count, :integer, default: 0
  end
end
