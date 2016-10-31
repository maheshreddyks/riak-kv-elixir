defmodule Connect do

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

	# insert data in double quotes except value
	def newobj(table,device,string,value) do
		Riak.Timeseries.put(get_pid(),table,[{device, string, getpt(), value}])
	end

	# insert tandom values 1 per sec change table
	def newrand() do
		Process.sleep(1000)
		#dev = to_string(device)
		#str = to_string(string)
		#tab = to_string(table)
		Riak.Timeseries.put(get_pid(),"SampleVTable",[{"device 100", "string" <>" " <> to_string(Enum.take_random(1..12,1) |> List.first), getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0}])
		newrand()
	end


	# autogenration for 150values per sec
	def autogenvoltage() do
		Process.sleep(1000)
		Riak.Timeseries.put(get_pid(),"SampleVTable",[
			{"device 1", "string 1" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 1", "string 2" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 1", "string 3" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 1", "string 4" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 1", "string 5" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 1", "string 6" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 1", "string 7" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 1", "string 8" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 1", "string 9" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 1", "string 10" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 2", "string 1" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 2", "string 2" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 2", "string 3" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 2", "string 4" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 2", "string 5" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 2", "string 6" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 2", "string 7" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 2", "string 8" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 2", "string 9" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 2", "string 10" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 3", "string 1" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 3", "string 2" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 3", "string 3" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 3", "string 4" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 3", "string 5" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 3", "string 6" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 3", "string 7" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 3", "string 8" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 3", "string 9" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 3", "string 10" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0}
			])
		autogen()

	end

	# query
	def query(table,spec,value1,colom1,colom2) do
		col1 = String.to_charlist(colom1)
		col2 = String.to_charlist(colom2)
		Riak.Timeseries.query(get_pid(),"select * from #{table} where time > #{get_time(spec, value1)} and time < #{getpt()} and device = '#{col1}' and string = '#{col2}' ")
	end
	# Counts the avg query
	def avgquery(table,spec,value1,colom1,colom2) do
		col1 = String.to_charlist(colom1)
		col2 = String.to_charlist(colom2)
		# IO.inspect "hello #{get_time(spec, value1)} and time < #{getpt()}"
		Riak.Timeseries.query(get_pid(),"select avg(voltages) from #{table} where time > #{get_time(spec, value1)} and time < #{getpt()} and device = '#{col1}' and string = '#{col2}' ")
	end

	# Counts the objects in query
	def countquery(table,spec,value1,colom1,colom2) do
		col1 = String.to_charlist(colom1)
		col2 = String.to_charlist(colom2)
		# IO.inspect "hello #{get_time(spec, value1)} and time < #{getpt()}"
		Riak.Timeseries.query(get_pid(),"select count(voltages) from #{table} where time > #{get_time(spec, value1)} and time < #{getpt()} and device = '#{col1}' and string = '#{col2}' ")
	end
	
	# get list of a table
	def getlist() do
		Riak.Timeseries.list!(get_pid(),"SampleTable")
	end

	# get present time in UNIX timestamp
	def getpt() do
		String.to_integer(date! |> format("x"))
	end

	# get time in UNIX ts
	def get_time(spec, value) do
		case spec do
			:min -> String.to_integer(date! |> subtract(value, :minutes) |> format("x"))
			:hr -> String.to_integer(date! |> subtract(value, :hours) |> format("x"))
			:day -> String.to_integer(date! |> subtract(value, :days) |> format("x"))
		end
	end

end