component = require "component";
pr = component.openprinter;

assert(pr.getPaperLevel() > 0, "Out of paper");
assert(pr.getBlackInkLevel() > 0, "Out of black ink");
if not pr.getColorInkLevel() > 0 then print "Out of color ink" end;

pr.clear();

--Copy title
-- No way to read it
pr.setTitle("copy")

-- Copy lines
for line = 0,19 do
	local text = pr.scan(nil,line)
	pr.writeln(text);
end
