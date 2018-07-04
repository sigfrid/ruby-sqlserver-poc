require 'tiny_tds'
require 'active_support/core_ext/hash/conversions'

client = TinyTds::Client.new( username: 'sa',
                              password: 'Passw0rd',
                              host: '10.0.7.191',
                              port: 1433,
                              timeout: 0,
                              database: 'ServiceBrokerMonolog')
loop do
  results = client.execute("WAITFOR (RECEIVE conversation_handle, message_body, message_enqueue_time FROM Notifications);")

  results.each do |row|
    client.execute("END CONVERSATION '#{row['conversation_handle']}';")

    values =  Hash.from_xml(row['message_body'])["root"]
    #<root><first type="string">lorem</first><second type="integer">0</second></root>
    puts values
  end

  # Rescue DBPROCESS is dead or not enabled (TinyTds::Error)
end

=begin
{ "status"=>1,
  "priority"=>5,
  "queuing_order"=>4,
  "conversation_group_id"=>"A0BE433E-F36B-1410-80E9-00A3020E36B8",
  "conversation_handle"=>"A5BE433E-F36B-1410-80E9-00A3020E36B8",
  "message_sequence_number"=>0,
  "service_name"=>"NotificationService",
  "service_id"=>65537,
  "service_contract_name"=>"DEFAULT",
  "service_contract_id"=>6,
  "message_type_name"=>"DEFAULT",
  "message_type_id"=>14,
  "validation"=>"N",
  "message_body"=>"This is the message payload",
  "message_enqueue_time"=>2018-07-04 11:59:50 +0200
 }
=end
