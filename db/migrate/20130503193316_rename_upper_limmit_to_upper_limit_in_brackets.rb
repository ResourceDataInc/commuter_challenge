class RenameUpperLimmitToUpperLimitInBrackets < ActiveRecord::Migration
  change_table :brackets do |t|
    t.rename :upper_limmit, :upper_limit
  end
end
