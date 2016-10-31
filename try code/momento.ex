defmodule Timestamp do
	import Momento
	def getmin(minutes) do
		String.to_integer(date! |> subtract(minutes, :minutes) |> format("x"))
	end
	def gethr(hours) do
		String.to_integer(date! |> subtract(hours, :hours) |> format("x"))
	end
	def getday(days) do
		String.to_integer(date! |> subtract(days, :days) |> format("x"))
	end
end