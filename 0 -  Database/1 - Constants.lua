function utf8(n)
	return string.uchar(n)
end

SubNumbers={185, 178, 179, 8308, 8309, 8310, 8311, 8312, 8313}

function numberToSub(w,n)
	return w..utf8(SubNumbers[tonumber(n)])
end

Constants	= {}
Constants["aG"] = {info="Gravity acceleration", value="9.81", unit="m*s^-2" }
Constants["C"] = {info="Speed of light", value="2.9979*10^8", unit="m/s"}
Constants["pi"]	= {info="PI", value="pi", unit=nil}
Constants[utf8(960)] = Constants["pi"]
