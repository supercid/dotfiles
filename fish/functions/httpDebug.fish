function httpDebug 
	# Download a web page and show info on what took time
	/usr/bin/curl "$argv" -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n";
end