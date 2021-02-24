/* [Hidden] */
// Special variables
// Minimum angle
$fa = 1;
// Minimum size
$fs = 0.1;

/* [Colors for previews] */
// See wiki: https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Transformations#color
// Color of Square
squareColor = "Aqua"; // [Lavender, Thistle, Plum, Violet, Orchid, Fuchsia, Magenta, MediumOrchid, MediumPurple, BlueViolet, DarkViolet, DarkOrchid, DarkMagenta, Purple, Indigo, DarkSlateBlue, SlateBlue, MediumSlateBlue]
// Color of Tabs
tabColor = "RoyalBlue";
// Color of Slots
slotColor = "Magenta";

/* [Scale and clearance] */
// Better to use squareSize and squareHeight
// for changing the size
// Scale of output
scale = 1; // [0.01:0.01:10]
// Clearance, makes slots bigger
clearance = 0.02; // [0:0.01:0.1]

/* [Size and Height] */
// Size in millimeters
squareSize = 35;
// Height in millimeters
squareHeight = 5;

// Presets, should normally not be changed
// Tab
tabHeight = squareHeight / 2;
tabLength = squareSize / 4;

// Tab Cutout
tabCutoutWidth = tabLength * 0.5;
tabCutoutLength = tabLength * 2;
// The "+1" makes it look better in previews,
// and dosen't modify anything
tabCutoutHeight = tabHeight + 1;

// Square module
module square() {
  color(squareColor)
    cube([squareSize, squareSize, squareHeight], center=true);
}


// https://english.stackexchange.com/a/47672
// Tabs module
module tab() {
  difference() {
    // Main tab square
    cube([squareSize / 2, tabLength, tabHeight], center=true);
    // Left cutout
    translate([-tabLength, 0, 0]) {
      rotate([0, 0, 30]) {
        cube([tabCutoutWidth, tabCutoutLength, tabCutoutHeight], center=true);
      }
    }
    // Right cutout
    translate([tabLength, 0, 0]) {
      rotate([0, 0, -30]) {
        cube([tabCutoutWidth, tabCutoutLength, tabCutoutHeight], center=true);
      }
    }
  }
}

// https://minecraft.gamepedia.com/Coordinates
// South
tabPositiveY = [0, squareSize / 2 + tabLength / 2, -tabHeight / 2];
// North
tabNegativeY = [0, -squareSize / 2 - tabLength / 2, -tabHeight / 2];
// East
tabPositiveX = [squareSize / 2 + tabLength / 2, 0, -tabHeight / 2];
// West
tabNegativeX = [-squareSize / 2 - tabLength / 2, 0, -tabHeight / 2];

// Tab positions
module tabSouth() {
  translate(tabPositiveY)
    rotate([0, 0, 0])
      tab();
}
module tabNorth() {
  translate(tabNegativeY)
    rotate([0, 0, 180])
      tab();
}
module tabEast() {
  translate(tabPositiveX)
    rotate([0, 0, -90])
      tab();
}
module tabWest() {
  translate(tabNegativeX)
    rotate([0, 0, 90])
      tab();
}


module slot() {
  // Adding clearance
  scale([1 + clearance, 1 + clearance, 1 + clearance])
    tab();
}

// South
slotPositiveY = [0, squareSize / 2 - tabLength / 2, -tabHeight / 2];
// North
slotNegativeY = [0, -squareSize / 2 + tabLength / 2, -tabHeight / 2];
// East
slotPositiveX = [squareSize / 2 - tabLength / 2, 0, -tabHeight / 2];
// West
slotNegativeX = [-squareSize / 2 + tabLength / 2, 0, -tabHeight / 2];

// Slots module
module slotSouth() {
  translate(slotPositiveY)
    rotate([0, 0, 180])
      slot();
}
module slotNorth() {
  translate(slotNegativeY)
    rotate([0, 0, 0])
      slot();
}
module slotEast() {
  translate(slotPositiveX)
    rotate([0, 0, 90])
      slot();
}
module slotWest() {
  translate(slotNegativeX)
    rotate([0, 0, -90])
      slot();
}








scale(scale) {
  difference() {
    square();
    color(slotColor) {
      // Add slots here:
      // slotSouth();
      slotNorth();
      // slotEast();
      // slotWest();
    }
  }
  color(tabColor) {
    // Add tabs here:
    tabSouth();
    // tabNorth();
    // tabEast();
    // tabWest();
  }
}









