require 'rubygems'
require 'active_record'
require 'yaml'
require File.dirname(__FILE__) + '/stored_procedure.rb'

class DbSupport
  def initialize
    #connect to db
    db_config = YAML::load(File.open(File.dirname(__FILE__) + '/database.yml'))
    ActiveRecord::Base.establish_connection(db_config);
  end

  def execute_function(procedure)
    #run sql query
    start_time = Time.now
    query_return = ActiveRecord::Base.connection.execute(procedure)
    query_time = Time.now - start_time
    #print query results
    puts "#{procedure[0,70]+"...\n"} function execution succeed and took: #{(query_time*1000).to_d(7)}mS" unless query_return[0]['status'] != '200'
    return query_return
  end

  def execute_query(sql_query)
    #run sql query
    start_time = Time.now
    begin
      query_return = ActiveRecord::Base.connection.execute(sql_query)
    rescue Exception => e
      raise e unless (e.message=~/TypeError/) == 0
    end
    query_time = Time.now - start_time
    #print query results
    if query_return.kind_of?(PG::Result)
        query_return.each do |item|
          p item
        end
      puts "Total query time: #{(query_time*1000).to_d(7)}mS."
    end
    return query_return
  end
end
