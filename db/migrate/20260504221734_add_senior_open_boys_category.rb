class AddSeniorOpenBoysCategory < ActiveRecord::Migration[8.0]
  def up
    Category.find_or_create_by!(name: "Senior Open Boys") do |c|
      c.sort_order = 20
    end
  end

  def down
    Category.find_by(name: "Senior Open Boys")&.destroy
  end
end
