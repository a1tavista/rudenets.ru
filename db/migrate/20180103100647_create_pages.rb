class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.string :url
      t.string :title
      t.string :content
    end
  end

  ActiveRecord::Base.connection.execute("INSERT INTO pages VALUES (null, 'about', 'Обо мне', 'nothing')")
end
