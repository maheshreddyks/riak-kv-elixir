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
		Riak.Timeseries.put(get_pid(),"SampleVTable",[{"device100", "string" <>" " <> to_string(Enum.take_random(1..12,1) |> List.first), getpt(), (Enum.take_random(600..1000,1) |> List.first)/1.0}])
		newrand()
	end

	# query
	def query(table,spec,value1) do
		Riak.Timeseries.query(get_pid(),"select * from #{table} where time > #{get_time(spec, value1)} and time < #{getpt()} and device = 'device100' and string = 'string 1'")
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


