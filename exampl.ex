


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

Riak.Timeseries.query("select * from SampleVTable where voltages > 740 and time < 650 and device = '' and string = ''")

Riak.Timeseries.put("GeoCheckin", [{"region1", "state1", 25, "hot", 23.0}])

Riak.Timeseries.put pid,"SampleVTable", [{"device 1", "string 1",:calendar.local_time(),623.0}]

Riak.Timeseries.put("SampleVTable", [
    {"Device 1", "st 1", 25, "hot", 23.0},
    {"region2", "state99", 26, "windy", 19.0}
])

Riak.Timeseries.put(get_pid(),"SampleTable",[
	{"device100", "string 1" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
	{"device100", "string 2" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
	{"device100", "string 3" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
	{"device100", "string 4" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
	{"device100", "string 5" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
	{"device100", "string 6" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
	{"device100", "string 7" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
	{"device100", "string 8" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
	{"device100", "string 9" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
	{"device100", "string 10" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0}])


riak-admin bucket-type create SampleVTable '{"props":{"table_def": "CREATE TABLE SampleVTable (device VARCHAR NOT NULL, string VARCHAR NOT NULL, time TIMESTAMP NOT NULL, voltages DOUBLE, PRIMARY KEY ((device, string, QUANTUM(time, 15, 'm')), device, string, voltages))"}}'
riak-admin bucket-type activate SampleVTable

Riak.Timeseries.put pid,"SampleVTable", [{"device 1", "string 4",Timestamp.getmin(0),680}]

163.172.170.141

Connect.start "163.172.170.141","8087"

Connect.newobj("device 101","string 101", "789")

Connect.newobj('SampleVTable','device 101','string 101', '789')

# insert
	def newobj() do
		#dev = to_string(device)
		#str = to_string(string)
		#tab = to_string(table)
		Riak.Timeseries.put(get_pid(),"SampleVTable",[{"device100", "string" <>" " <> to_string(Enum.take_random(1..12,1) |> List.first), getpt(), Enum.take_random(600..1000,1) |> List.first}])
	end

	import Momento
	
	h =String.to_integer date! |> format "x"

	String.to_integer(date! |> subtract(2, :hours) |> format("x")) 
	
	Riak.Timeseries.query(pid,"select count(voltages) from SampleTable where time > 1469558053787 and time < 1469644860600 and device = 'device 1' and string = 'string 1'")