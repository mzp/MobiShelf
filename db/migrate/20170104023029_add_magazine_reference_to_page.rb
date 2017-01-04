class AddMagazineReferenceToPage < ActiveRecord::Migration[5.0]
  def up
    add_reference(:pages, :magazine)
  end

  def down
    remove_reference(:pages, :magazine)
  end
end
