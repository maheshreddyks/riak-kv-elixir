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

	# insert
	def newobj(table_name,device,string,value) do
		Riak.Timeseries.put get_pid(),table_name,
		[{device, string,String.to_integer(date! |> format("x")),value}]
	end

	# query
	def query(table,spec,value1) do
		Riak.Timeseries.query get_pid(), to_string(select * from table where time > get_time(spec, value1) and device = 'device 1' and string = 'string 4')
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


