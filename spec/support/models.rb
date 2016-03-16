RSpec.configure do |config|
  config.before(:suite) do
    ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')

    silence_stream(STDOUT) do
      ActiveRecord::Schema.define(version: Time.now.strftime("%Y%m%d%H%M%S")) do
        create_table "hoges", force: true do |t|
          t.datetime "deleted_at"
        end
      end
    end

    class Hoge < ActiveRecord::Base
      soft_deletable
    end
  end

  config.after(:each) do
    ActiveRecord::Base.connection.execute "DELETE FROM hoges;"
  end
end
