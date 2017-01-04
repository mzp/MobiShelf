class AddContentsToPages < ActiveRecord::Migration[5.0]
  def up
    add_attachment :pages, :content
  end

  def down
    remove_attachment :pages, :content
  end
end
