require 'tiny_tds'
require 'active_support/core_ext/hash/conversions'

client = TinyTds::Client.new( username: 'sa',
                              password: 'Passw0rd',
                              host: '10.0.7.191',
                              port: 1433,
                              timeout: 0,
                              database: 'ServiceBrokerTest')
loop do
  results = client.execute("WAITFOR (RECEIVE * FROM NotificationsQueue);")

  results.each do |row|
    values =  Hash.from_xml(row['message_body'])#["root"]
    puts values
  end
end
