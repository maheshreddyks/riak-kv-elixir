defmodule Time do
	def  yesterday_day_start() do
		%{Calendar.DateTime.now!("Asia/Kolkata")| day: (Calendar.DateTime.now!("Asia/Kolkata")).day-1 , hour: 10 ,minute: 0, second: 0 }
		|> Calendar.DateTime.Format.unix
	end
	
	def present_day_end() do
		Calendar.DateTime.now!("Asia/Kolkata") 

	end

end