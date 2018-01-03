class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.string :url
      t.string :title
      t.string :content
    end
    ActiveRecord::Base.connection.execute("INSERT INTO pages VALUES (1, 'about', 'Обо мне', 'nothing')")
  end
end
