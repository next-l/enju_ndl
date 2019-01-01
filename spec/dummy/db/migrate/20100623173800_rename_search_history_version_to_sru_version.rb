class RenameSearchHistoryVersionToSruVersion < ActiveRecord::Migration[4.2]
  def self.up
    rename_column :search_histories, :version, :sru_version
  end

  def self.down
    rename_column :search_histories, :sru_version, :version
  end
end
