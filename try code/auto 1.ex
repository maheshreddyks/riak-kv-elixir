defmodule Auto do

	import Momento

	def start(id , port) do
		pidtable = :ets.new(:spid_name, [:named_table])
		ipid = String.to_charlist(id)
		iport = String.to_integer(port)
		{:ok, pid} = Riak.Connection.start_link(ipid, iport)
		:ets.insert(pidtable,{"pid", pid})
	end

	# gets pid value 
	def get_pid do
		{_,p_value}= :ets.lookup(:spid_name,"pid") |> hd 
		p_value
	end

	def gen() do
		count = [1]
	end

	def autogen(count) do
		# value = date!

		
		# Process.sleep(300000)
		# autogen()
	end

	# get present time in UNIX timestamp
	def getpt() do
		String.to_integer(date! |> format("x"))
	end

	def time(day) do
		count = []
		#day = []
	# 	z = %DateTime{calendar: Calendar.ISO, day: 21, hour: 17, microsecond: {966643, 6},
 # minute: 0, month: 9, second: 49, std_offset: 0, time_zone: "Etc/UTC",
 # utc_offset: 0, year: 2016, zone_abbr: "UTC"}
		z = %{date! | hour: 18, minute: 0, second: 0}
	 	get_time(count,day,z)
	end

	def get_time(count,day,z) do
		if length(count) == 34 do
	# 		z = %DateTime{calendar: Calendar.ISO, day: 21, hour: 17, microsecond: {966643, 6},
 # minute: 0, month: 9, second: 49, std_offset: 0, time_zone: "Etc/UTC",
 # utc_offset: 0, year: 2016, zone_abbr: "UTC"}
 			z = %{date! | hour: 17, minute: 0, second: 0} 
			count = [1]
			day = day ++ [1]
			if length(day) == 2 do
				date!	  
			else
				k = z |> subtract(length(day), :day)
				IO.inspect k
				get_time(count,day,k)
			end
		else
			#s = String.to_integer(date! |> subtract( r, :minutes) |> format("x"))
			k = String.to_integer(z |> subtract( 15, :minutes) |> format("x"))
			k1 = z |> subtract( 15, :minutes)
			count = count ++ [1]
			voltage = case z.hour do
			9 	-> 0
			18 	-> 0
			10   ->(Enum.take_random(600..650,1) |> List.first)/1.0
			11  ->(Enum.take_random(650..700,1) |> List.first)/1.0
			12   ->(Enum.take_random(700..750,1) |> List.first)/1.0
			13   ->(Enum.take_random(750..800,1) |> List.first)/1.0
			14   ->(Enum.take_random(800..850,1) |> List.first)/1.0
			15   ->(Enum.take_random(850..900,1) |> List.first)/1.0
			16   ->(Enum.take_random(700..750,1) |> List.first)/1.0
			17   ->(Enum.take_random(650..700,1) |> List.first)/1.0			    
			end
			Riak.Timeseries.put(get_pid(),"SampleTelemetry3",[{"421830cd-ff47-3865-aa48-f5f78f4e09d1-01" , k, voltage}])

			 IO.inspect length(count)
			 IO.inspect voltage
			 IO.inspect k1.hour
			get_time(count,day,k1)
		end
	end
	def qu(spec,value1,colom1) do
		col1 = String.to_charlist(colom1)
		q=Riak.Timeseries.query(get_pid(),"select count(voltages) from SampleTelemetry3 where time > #{get_TTtime(spec, value1)} and time < #{getpt}  and string =  '#{col1}' ")
		w = Riak.Timeseries.query(get_pid(),"select avg(voltages) from SampleTelemetry3 where time > #{get_TTtime(spec, value1)} and time < #{getpt}  and string =  '#{col1}' ")	
		e = Riak.Timeseries.query(get_pid(),"select * from SampleTelemetry3 where time > #{get_TTtime(spec, value1)} and time < #{getpt}  and string =  '#{col1}'' ")	
		IO.inspect q
		IO.inspect w
		IO.inspect e
	end

	def timepick() do
		start_time = String.to_integer(  %{date! | hour: 6, minute: 0, second: 0} |> format("x"))
		end_time = String.to_integer(  %{date! | hour: 19, minute: 0, second: 0} |> format("x")) 
		Riak.Timeseries.query(get_pid(),"select * from SampleTelemetry3 where time > start_time and time < end_time  and string = 'b1ffba16-18f4-3d52-a955-4a4217db87d1-09' ")
		# IO.inspect date!

		# IO.inspect start_time

		# IO.inspect end_time	
	end

	def get_TTtime(spec, value) do
		case spec do
			:min -> String.to_integer(date! |> subtract(value, :minutes) |> format("x"))
			:hr -> String.to_integer(date! |> subtract(value, :hours) |> format("x"))
			:day -> String.to_integer(date! |> subtract(value, :days) |> format("x"))
		end
	end

	def pi(string,incident,threat) do
		Riak.Timeseries.put(get_pid(),
			"Alert",
			[{string , getpt(),incident, threat}])	
	end

	def pn(userid,type,message) do
		Riak.Timeseries.put(get_pid(),
			"Notification",
			[{userid, type , getpt(), message}])	
	end

	def pa(device,string,message) do
		Riak.Timeseries.put(get_pid(),
			"Activities",
			[{device ,string, getpt(), message}])	
	end

end