defmodule Connect do

	# mention id and port in "10....1","8087"
	def start(id , port) do
		pidtable = :ets.new(:spid_name, [:named_table])
		ipid = String.to_charlist(id)
		iport = String.to_integer(port)
		{:ok, pid} = Riak.Connection.start_link(ipid, iport)
		:ets.insert(pidtable,{"pid", pid})
	end
	# mention bucket,key,data in double quotes
	def new(bucket,key,data) do
		new = Riak.Object.create(bucket: bucket, key: key, data: data, content_type: 'application/json')
		{_,p_value}= :ets.lookup(:spid_name,"pid") |> hd 
		Riak.put(p_value, new)
	end

	# mention bucket,key in double quotes and datamap in the map format
	def newmap(bucket,key,datamap) do
		data = Poison.encode! datamap
		new = Riak.Object.create(bucket: bucket, key: key, data: data, content_type: 'application/json')
		{_,p_value}= :ets.lookup(:spid_name,"pid") |> hd 
		Riak.put(p_value, new)
	end

	# mention bucket,key in double quotes
	def find(bucket,key) do
		{_,p_value}= :ets.lookup(:spid_name,"pid") |> hd 
		find = Riak.find(p_value, bucket, key)
	end

	# mention bucket,key in double quotes
	def delete(bucket,key) do
		{_,p_value}= :ets.lookup(:spid_name,"pid") |> hd 
		find = Riak.delete(p_value, bucket, key)
	end

	def update(bucket,key,value,upvalue) do
		{_,p_value}= :ets.lookup(:spid_name,"pid") |> hd 
		finded = Riak.find(p_value, bucket, key)
		upd = finded.data
		inspect "data #{upd}"
		# datadec = Poison.Parser.parse!(upd,keys: :atoms!)
		# inspect "data #{datadec}"
		# uppeddata = put_in(datadec[String.to_atom value] ,upvalue)
		# data = Poison.encode! uppeddata
		# Riak.put(p_value, data)
		 
		# new = Riak.Object.create(bucket: bucket, key: key, data: data, content_type: 'application/json')
		# {_,p_value}= :ets.lookup(:spid_name,"pid") |> hd 
	end

end


