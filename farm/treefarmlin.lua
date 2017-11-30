component = require ("component");
robot = component.robot;
robotlib = require ("robot");
sides = require ("sides");

local linesize = 12;

magnet = component.tractor_beam;    -- optional in the future?
function vacuum()
    while magnet.suck() do end;
end

function harvestTree()
    -- We're 1 above ground level - return to this altitude
    -- A tree was discovered in front of us
    -- Harvest the tree, replant the sapling

    robot.swing(sides.front);
    robot.move(sides.front);

    local height = 0;
    while (robot.swing(sides.up)) do 
        robot.move(sides.up);
        height = height + 1;
    end
    for i in 1,height do
        robot.move(sides.down);
    end
    robot.swing(sides.down);

    os.sleep(2);
    vacuum();

    robot.select(1);
    return robot.place(sides.down);
end

function makeMove()
    local res,err = robot.move(sides.forward);
    if not res then 
        if err == "solid" then
            return harvestTree();
        else 
            print (res);
            return makeMove();
        end
    end
    return true;
end

function doLine()
    for i=1,linesize do
        assert(makeMove());
    end
end

while true do
    doLine();
    robot.turn(true);
    robot.turn(true);
    doLine();
    for i = 2,robot.inventorySize() do
        if (robot.count(i)>0) then
            robot.select(i);
            robot.drop(sides.down,math.huge);
        end
    end;
    robot.turn(true);
    robot.turn(true);
    os.sleep(30);
end
