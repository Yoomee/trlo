class AddThemeToSites < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :theme, :string
  end
end
