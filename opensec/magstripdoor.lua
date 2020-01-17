com = require ("component");
event = require ("event");

readers = {};
readers["d5040a92-6c36-4f7c-ba7d-dadf31cd6a38"] = com.proxy("9f36dd62-50e1-4d59-9b58-b66bcbb1282b");
readers["ffb1ebd4-298e-4ec6-982d-b54708f9e00b"] = com.proxy("2286d333-689e-4bfb-ba1c-ca2a1330ba6a");

doorpassword = nil;

authkeys = {
	"87d9297f12dd786259f85d0d0761069ec8ee6d4e6fde05de5e08ff8408ca8a75"
}
function dehex(str)	return string.gsub(str,"(%x%x)", function(s) return string.char(tonumber(s,16)) end ); end
for k,v in ipairs(authkeys) do
	authkeys[k]=dehex(v)
end

local data = com.os_datablock;
function auth (key) 
	local hash = data.sha256(key);
	-- any of
	for _,v in ipairs(authkeys) do
		if hash == v then return true end
	end
	return false;
end

addlog = loadfile ("printerlog") or
function (t)
	print (table.unpack(t));
end

function magData (_, readaddr, user, carddata, cardid, cardlocked, somenumber)
	if not auth(carddata) then return end;

	local door = readers[readaddr];
	print (door.address);
	door.open(doorpassword);
	event.timer(2,function() door.close(doorpassword) end);
end

magdata_evt = event.listen("magData",magData);
event.pull ("interrupted");
--event.ignore ("magData",magData);
event.cancel (magdata_evt);
