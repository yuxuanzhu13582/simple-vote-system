class AddCounterToCandidate < ActiveRecord::Migration[6.1]
  def change
    add_column :candidates, :vote_logs_count, :integer
  end
end
