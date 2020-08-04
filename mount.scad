/*
Sortera box cover constraints
*/
innerElevationDifference=12;
elevationWidth=38;
totalHeight=51;
materialWidth=1;
innerEdgeRadius=10;
outerEdgeRadius=40;
cover2MainbodyGap=4;
/*
400*300 Euro box bottom constraints
*/
stackProfileMargin=11;
euroDepth=300-(innerEdgeRadius+outerEdgeRadius);
euroWidth=400;
/*
Mount constraints
*/
materialThickness=1;

use <prism.scad>;

module sideElement(depth, isMain) {
    //sidecover
    difference() {
    cube([materialWidth,depth,totalHeight]);
        for(i = [5:15:depth-20]) {
            translate([-1,i,5])  cube([materialWidth+2,5,totalHeight-10]);
        }
    }
    //elevation cover w/ latch
    translate([0,0,totalHeight]) {
        cube([elevationWidth+materialWidth,
            depth,materialWidth]);
        
        if(isMain) {
            translate([stackProfileMargin,stackProfileMargin,materialWidth]) mirror([1,0,0]) prism(depth-stackProfileMargin,stackProfileMargin,19);
        } else {
            translate([stackProfileMargin,0,materialWidth]) mirror([1,0,0]) prism(depth,stackProfileMargin,19);
        }
        
        translate([elevationWidth+materialWidth,
            0,(-innerElevationDifference)+materialWidth]) {
            cube([materialWidth,depth,
                innerElevationDifference]);
        }
        
    }
    cube([cover2MainbodyGap+materialWidth,depth,materialWidth]);
    for(i = [5:40:depth]) {
        translate([cover2MainbodyGap+materialWidth,i,0]) {
            prism(8,1.2,2);
        }
    }
}

module edgeElement(length) {
    CubePoints = [
  [  0,  0,  0 ],  //0
  [ outerEdgeRadius,  0,  0 ],  //1
  [ outerEdgeRadius+innerEdgeRadius,  innerEdgeRadius,  0 ],  //2
  [  outerEdgeRadius+innerEdgeRadius,  outerEdgeRadius+innerEdgeRadius,  0 ],  //3
  [  0,  0,  materialWidth ],  //4
  [ outerEdgeRadius,  0,  materialWidth ],  //5
  [ outerEdgeRadius+innerEdgeRadius,  innerEdgeRadius,  materialWidth ],  //6
  [  outerEdgeRadius+innerEdgeRadius,  outerEdgeRadius+innerEdgeRadius,  materialWidth ]]; //7
  
CubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
  
polyhedron( CubePoints, CubeFaces );
    
}

sideElement(euroDepth, true);
translate([0,euroDepth,totalHeight])  edgeElement();
translate([outerEdgeRadius+innerEdgeRadius, euroDepth+innerEdgeRadius+ elevationWidth+materialWidth*2,0]) rotate([0,0,-90]) sideElement(20);

translate([stackProfileMargin,stackProfileMargin,totalHeight+materialWidth]) rotate([0,0,-90]) prism((elevationWidth-stackProfileMargin)+materialWidth*2,stackProfileMargin,19);

