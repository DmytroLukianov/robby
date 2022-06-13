# robby

Steps to run app:

0) Install ruby >= 3.0.3

1) Open project directory
```
cd robby
```
2) Run robby
```
ruby lib/robby.rb
```

## Main commands

**Note:** *Commands should be entered one by one*

**Note 2:** *The first valid command to the robot is a PLACE command, after that, any sequence of commands may be issued, in any order, including another PLACE command*

##### PLACE X, Y, F
- PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.

##### MOVE
- MOVE will move the toy robot one unit forward in the direction it is currently facing.

##### LEFT
##### RIGHT
- LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot.

##### REPORT
- REPORT will announce the X,Y and orientation of the robot.

## Additional commands

##### HELP
- HELP will display help info about main commands

##### DEBUG
- DEBUG will enable debug mode and for each main command will be shown table visualisation and info about robot position and direction

##### EXIT
- REPORT will close application

Example Input and Output:

```plain
PLACE 0,0,NORTH
MOVE
REPORT
Output: 0,1,NORTH
```

```plain
PLACE 0,0,NORTH
LEFT
REPORT
Output: 0,0,WEST
```

```plain
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
Output: 3,3,NORTH
```
