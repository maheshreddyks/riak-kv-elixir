defmodule Connect do

	import Momento

	# mention id and port in "10....1","8087"
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

	# insert
	def newrand() do
		Process.sleep(1000)
		#dev = to_string(device)
		#str = to_string(string)
		#tab = to_string(table)
		Riak.Timeseries.put(get_pid(),"SampleVTable",[{"device 100", "string" <>" " <> to_string(Enum.take_random(1..12,1) |> List.first), getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0}])
		newrand()
	end

	def autogen() do
		Riak.Timeseries.put(get_pid(),"SampleTable",[
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
			{"device 3", "string 10" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 4", "string 1" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 4", "string 2" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 4", "string 3" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 4", "string 4" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 4", "string 5" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 4", "string 6" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 4", "string 7" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 4", "string 8" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 4", "string 9" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 4", "string 10" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 5", "string 1" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 5", "string 2" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 5", "string 3" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 5", "string 4" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 5", "string 5" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 5", "string 6" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 5", "string 7" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 5", "string 8" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 5", "string 9" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 5", "string 10" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 6", "string 1" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 6", "string 2" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 6", "string 3" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 6", "string 4" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 6", "string 5" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 6", "string 6" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 6", "string 7" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 6", "string 8" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 6", "string 9" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 6", "string 10" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 7", "string 1" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 7", "string 2" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 7", "string 3" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 7", "string 4" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 7", "string 5" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 7", "string 6" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 7", "string 7" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 7", "string 8" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 7", "string 9" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 7", "string 10" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 8", "string 1" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 8", "string 2" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 8", "string 3" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 8", "string 4" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 8", "string 5" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 8", "string 6" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 8", "string 7" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 8", "string 8" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 8", "string 9" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 8", "string 10" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 9", "string 1" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 9", "string 2" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 9", "string 3" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 9", "string 4" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 9", "string 5" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 9", "string 6" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 9", "string 7" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 9", "string 8" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 9", "string 9" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 9", "string 10" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 10", "string 1" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 10", "string 2" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 10", "string 3" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 10", "string 4" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 10", "string 5" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 10", "string 6" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 10", "string 7" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 10", "string 8" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 10", "string 9" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 10", "string 10" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 11", "string 1" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 11", "string 2" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 11", "string 3" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 11", "string 4" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 11", "string 5" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 11", "string 6" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 11", "string 7" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 11", "string 8" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 11", "string 9" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 11", "string 10" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 12", "string 1" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 12", "string 2" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 12", "string 3" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 12", "string 4" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 12", "string 5" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 12", "string 6" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 12", "string 7" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 12", "string 8" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 12", "string 9" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 12", "string 10" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 13", "string 1" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 13", "string 2" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 13", "string 3" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 13", "string 4" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 13", "string 5" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 13", "string 6" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 13", "string 7" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 13", "string 8" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 13", "string 9" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 13", "string 10" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 14", "string 1" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 14", "string 2" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 14", "string 3" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 14", "string 4" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 14", "string 5" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 14", "string 6" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 14", "string 7" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 14", "string 8" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 14", "string 9" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 14", "string 10" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 15", "string 1" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 15", "string 2" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 15", "string 3" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 15", "string 4" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 15", "string 5" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 15", "string 6" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 15", "string 7" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 15", "string 8" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 15", "string 9" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0},
			{"device 15", "string 10" , getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0}])

	end

	# query
	def query(table,spec,value1) do
		Riak.Timeseries.query(get_pid(),"select * from #{table} where time > #{get_time(spec, value1)} and time < #{getpt()} and device = 'device 100' and string = 'string 1'")
	end

	def avgquery(table,spec,value1) do
		IO.inspect "hello #{get_time(spec, value1)} and time < #{getpt()}"
		Riak.Timeseries.query(get_pid(),"select avg(voltages) from #{table} where time > #{get_time(spec, value1)} and time < #{getpt()} and device = 'device 100' and string = 'string 1'")
	end

	def countquery(table,spec,value1) do
		IO.inspect "hello #{get_time(spec, value1)} and time < #{getpt()}"
		Riak.Timeseries.query(get_pid(),"select count(voltages) from #{table} where time > #{get_time(spec, value1)} and time < #{getpt()} and device = 'device 100' and string = 'string 1'")
	end
	
	def getlist() do
		Riak.Timeseries.list!(get_pid(),"SampleTable")
	end

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

	# get pid
	def get_pid do
		{_,p_value}= :ets.lookup(:spid_name,"pid") |> hd 
		p_value
	end
end


