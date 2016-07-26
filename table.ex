defmodule Connect do

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

	def newobj(table_name,device,string,time,value) do
		Riak.Timeseries.put table_name, [
    	{device, string,time,value}]
	end

end


