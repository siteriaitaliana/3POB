require 'rake'
require File.dirname(__FILE__) + '/connect.rb'

db = DbSupport.new
data_fixtures = []

#
#Usage instructions:
#1. Install Ruby v. >= 1.9.2
#2. From cli 'bundle install bundler'
#3. From cli postgresql_test do 'bundle install'
#4. Prepare the functions to be executed against the db by appending more functions to the following data_fixtures array
#   (the set of functions to be called are contained in the stored_procedure.rb file)
#   modify the rows:  GRANT EXECUTE ON FUNCTION function_name()TO username;
#   with your postgresql db username  #
#5. 'bundle exec rake'
# This rake task finally will run all the functions contained in data_fixtures by logging the query status, its execution time
# and will throw the eventual errors raised by postgresql and its constrains
#
#Functions list:
# create_customer(IN i_firstname text, IN i_lastname text, IN i_email text, IN i_password text, OUT status integer, OUT status_text text, OUT customer_id integer)
# create_order(IN i_key_customer integer, IN i_key_address integer, OUT status integer, OUT status_text text, OUT order_id integer)
# save_address(IN i_key_customer bigint, IN i_address_line1 text, IN i_address_line2 text, IN i_postcode text, IN i_country text, IN i_region text, IN i_city text, OUT status integer, OUT status_text text, OUT address_id integer)
# deliver_order(IN i_order_id integer, IN i_changed_by text,  OUT status integer, OUT status_text text)
#

### customer1, address1, order1, deliver1 set creation!
data_fixtures << create_customer('lorenzo', 'urbini', 'email@gmail.com', 'password')
customer1_id = db.execute_query("select id_customer from customer where firstname = 'lorenzo'").first['id_customer']
data_fixtures << create_address(customer1_id, '46 Palermo Road3', 'NW10 5YP', 'United Kingdom', 'London', 'London')
address1_id = db.execute_query("select id_address from address where key_customer = #{customer1_id}").first['id_address']
data_fixtures << create_order(customer1_id, address1_id)
order1_id = db.execute_query("select id_order from orders where key_customer = #{customer1_id} AND key_address = #{address1_id}").first['id_order']
data_fixtures << deliver_order(order1_id, 'lorenzo')
###



task :default => [:load_data_fixture]

desc "Populate the previously created skype postgresql database"
task :load_data_fixture do
  data_fixtures.each do |query|
    db.execute_function(query)
  end
end

desc "Run the specified postgresql query"
task :exec_query, :arg do |t, args|
  case args['arg']
    when "select_customer"
      db.execute_query("SELECT * FROM customer")
    when 'select_address'
      db.execute_query("SELECT * FROM address")
    when 'select_orders'
      db.execute_query("SELECT * FROM orders")
  end
end





