require 'rake'
require File.dirname(__FILE__) + '/connect.rb'

@db = DbSupport.new

#
#Usage instructions:
#1. Install Ruby v. >= 1.9.2
#2. From cli 'bundle install bundler'
#3. From cli postgresql_test do 'bundle install'
#   (the set of functions to be called are contained in the stored_procedure.rb file)
#   modify the db access credentials in database.yml and the row:
#   GRANT EXECUTE ON FUNCTION function_name()TO username;
#   with your postgresql db username in every stores procedure
#4. 'bundle exec rake -T' for the full list of the available rake tasks
#
# This rake task finally will run all the functions contained in data_fixtures by logging the query status, its execution time
# and will throw the eventual errors raised by postgresql and its constrains
#
#Functions list:
# create_customer(IN i_firstname text, IN i_lastname text, IN i_email text, IN i_password text, OUT status integer, OUT status_text text, OUT customer_id integer)
# create_order(IN i_key_customer integer, IN i_key_address integer, OUT status integer, OUT status_text text, OUT order_id integer)
# save_address(IN i_key_customer bigint, IN i_address_line1 text, IN i_address_line2 text, IN i_postcode text, IN i_country text, IN i_region text, IN i_city text, OUT status integer, OUT status_text text, OUT address_id integer)
# deliver_order(IN i_order_id integer, IN i_changed_by text,  OUT status integer, OUT status_text text)
#

task :default => [:load_data_fixture]

desc "Populate the previously created skype postgresql database"
task :load_data_fixture do
  first_data_set
  second_data_set
  third_data_set
end

desc"""
Run the following postgresql query:
- select_customer
- select_address
- select_orders
- select_customer_and_address(id_customer)
- select_customer_orders(key_customer)
- select_undeliv_ord
"""
task :exec_query, :query, :param  do |t, args|
  case args['query']
    when 'select_customer'
      @db.execute_query("SELECT * FROM customer")
    when 'select_address'
      @db.execute_query("SELECT * FROM address")
    when 'select_orders'
      @db.execute_query("SELECT * FROM orders")
    when 'select_customer_and_address'
      @db.execute_query("SELECT firstname, lastname, email FROM customer WHERE id_customer = #{args['param']} UNION ALL SELECT address_line1, country, city  FROM address WHERE key_customer = #{args['param']} ")
    when 'select_customer_orders'
      @db.execute_query("SELECT id_order, key_status, delivered FROM orders WHERE key_customer = #{args['param']}")
    when 'select_undeliv_ord'
      @db.execute_query("SELECT id_order, key_status, delivered FROM orders WHERE delivered='TRUE'")
  end
end

def first_data_set
  ### customer1, address1, order1, deliver1 set creation!
  @db.execute_function(create_customer('lorenzo', 'urbini', 'lorenzo@gmail.com', 'password'))
  customer1_id = @db.execute_query("select id_customer from customer where firstname = 'lorenzo'").sort{|a,b| a[1] <=> b[1]}.last['id_customer']
  @db.execute_function(create_address(customer1_id, '46 Palermo Road3', 'NW10 5YP', 'United Kingdom', 'London', 'London'))
  address1_id = @db.execute_query("select id_address from address where key_customer = #{customer1_id}").sort{|a,b| a[1] <=> b[1]}.last['id_address']
  @db.execute_function(create_order(customer1_id, address1_id))
  order1_id = @db.execute_query("select id_order from orders where key_customer = #{customer1_id} AND key_address = #{address1_id}").sort{|a,b| a[1] <=> b[1]}.last['id_order']
  @db.execute_function(deliver_order(order1_id, 'Lorenzo'))
end

def second_data_set
  ### customer2, address2, order2, deliver2 set creation!
  @db.execute_function(create_customer('homer', 'simpson', 'homer.simpson@hotmail.com', 'password'))
  customer2_id = @db.execute_query("select id_customer from customer where firstname = 'homer'").sort{|a,b| a[1] <=> b[1]}.last['id_customer']
  @db.execute_function(create_address(customer2_id, '22 Simpson Street', '67800', 'United Sates', 'Utah', 'Springfield'))
  address2_id = @db.execute_query("select id_address from address where key_customer = #{customer2_id}").sort{|a,b| a[1] <=> b[1]}.last['id_address']
  @db.execute_function(create_order(customer2_id, address2_id))
  order2_id = @db.execute_query("select id_order from orders where key_customer = #{customer2_id} AND key_address = #{address2_id}").sort{|a,b| a[1] <=> b[1]}.last['id_order']
  @db.execute_function(deliver_order(order2_id, 'Homer'))
end

def third_data_set
  ### customer3, address3, order3, no delivery set creation!
  @db.execute_function(create_customer('diego', 'maradona', 'diegomaradone@libero.it', 'passwo83'))
  customer3_id = @db.execute_query("select id_customer from customer where firstname = 'diego'").sort{|a,b| a[1] <=> b[1]}.last['id_customer']
  @db.execute_function(create_address(customer3_id, '10 Avenue', 'Cahikos', 'ABC1209', 'Argentina', 'Mendoza', 'Buenos Aires'))
  address3_id = @db.execute_query("select id_address from address where key_customer = #{customer3_id}").sort{|a,b| a[1] <=> b[1]}.last['id_address']
  @db.execute_function(create_order(customer3_id, address3_id))
  ###
end







