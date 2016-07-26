


Connect.update "chinni","keyval33","map3","hell datais update"


Connect.start "139.59.12.105","8087" 


c "dataup.ex" 

riak-admin bucket-type create GeoCheckin 
'{"props":
	{"table_def": 
		"CREATE TABLE GeoCheckin 
			(region VARCHAR NOT NULL, 
				state VARCHAR NOT NULL, 
					time TIMESTAMP NOT NULL, 
						weather VARCHAR NOT NULL, 
							temperature DOUBLE, 
								PRIMARY KEY ((region, state, QUANTUM(time, 15, 'm'))
												, region, state, time))"}}'


Riak.Timeseries.put("GeoCheckin", [
    {"region1", "state1", 25, "hot", 23.0}
])

Riak.Timeseries.put("GeoCheckin", [
    {"region1", "state1", 25, "hot", 23.0},
    {"region2", "state99", 26, "windy", 19.0}
])

Riak.Timeseries.get("GeoCheckin", ["region1", "state1", 25])

Riak.Timeseries.list!("GeoCheckin")

Riak.Timeseries.delete("GeoCheckin", ["region2", "state99", 26])

Riak.Timeseries.query("select * from GeoCheckin where time > 24 and time < 26 and region = 'region1' and state = 'state1'")

Riak.Timeseries.put("GeoCheckin", [{"region1", "state1", 25, "hot", 23.0}])

Riak.Timeseries.put pid,"SampleVTable", [{"device 1", "string 1",:calendar.local_time(),623.0}]

Riak.Timeseries.put("SampleVTable", [
    {"Device 1", "st 1", 25, "hot", 23.0},
    {"region2", "state99", 26, "windy", 19.0}
])

{:ok, pid} = Riak.Connection.start_link '163.172.170.141',8087

riak-admin bucket-type create SampleVTable '{"props":{"table_def": "CREATE TABLE SampleVTable (device VARCHAR NOT NULL, string VARCHAR NOT NULL, time TIMESTAMP NOT NULL, voltages DOUBLE, PRIMARY KEY ((device, string, QUANTUM(time, 15, 'm')), device, string, voltages))"}}'
riak-admin bucket-type activate SampleVTable