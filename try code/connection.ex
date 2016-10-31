defmodule Connect do

	def start(id , port) do
		pidtable = :ets.new(:spid_name, [:named_table])
		ipid = String.to_charlist(id)
		iport = String.to_integer(port)
		{:ok, pid} = Riak.Connection.start_link(ipid, iport)
		:ets.insert(pidtable,{"pid", pid})
	end

	def new(bucket,key,data) do
		new = Riak.Object.create(bucket: bucket, key: key, data: data)
		{p_key,p_value}= :ets.lookup(:spid_name,"pid") |> hd 
		Riak.put(p_value, new)
	end

	def find(bucket,key) do
		{p_key,p_value}= :ets.lookup(:spid_name,"pid") |> hd 
		find = Riak.find(p_value, bucket, key)
	end

	def delete(bucket,key) do
		{p_key,p_value}= :ets.lookup(:spid_name,"pid") |> hd 
		Riak.delete(p_value,bucket,key)
	end

end