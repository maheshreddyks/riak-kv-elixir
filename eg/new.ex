defmodule New do
	def new(key,data,pid) do
		o = Riak.Object.create(bucket: "chinni", key: key, data: data)
		Riak.put(pid,o)
	end
end