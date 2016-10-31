defmodule Connect do

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
		Riak.put(get_pid(), new)
	end

	# mention bucket,key in double quotes
	def find(bucket,key) do
		find = Riak.find(get_pid(), bucket, key)
	end

	# mention bucket,key in double quotes
	def delete(bucket,key) do
		find = Riak.delete(get_pid(), bucket, key)
	end

	def update(bucket,key,value,upvalue) do
		finded = Riak.find(get_pid(), bucket, key)
		# IO.inspect finded
		updata = finded.data |> parse |> update(value,upvalue) |> encode 
		Riak.put get_pid(),%{finded | data: updata}
		# {:ok,datadec}= Poison.Parser.parse(upd)
		# uppeddata = put_in(datadec[String.to_atom value] ,upvalue)
		# data = Poison.encode! uppeddata		 
		# new = Riak.Object.create(bucket: bucket, key: key, data: data, content_type: 'application/json')
		# {_,p_value}= :ets.lookup(:spid_name,"pid") |> hd 
		# Riak.put(p_value, new)
	end
	def get_pid do
		{_,p_value}= :ets.lookup(:spid_name,"pid") |> hd 
		p_value
	end
	def update({:ok,data},key,upvalue) do
		put_in data[key],upvalue
	end
    def encode(data) do
     	Poison.encode! data
    end
    def parse data do 
    	Poison.Parser.parse data
    end

end


