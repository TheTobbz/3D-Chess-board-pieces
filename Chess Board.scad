$fa = 1;
$fs = 0.1;

scale = 1;

// Size and height in millimeters
squareSize = 30;
squareHeight = 5;

// Presets, should normally not be changed
tabHeight = squareHeight / 2;
tabLength = squareSize / 4;

// Square module
module square() {
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
        cube([tabLength * 0.5, tabLength * 2, tabHeight + 1], center=true);
      }
    }
    // Right cutout
    translate([tabLength, 0, 0]) {
      rotate([0, 0, -30]) {
        cube([tabLength * 0.5, tabLength * 2, tabHeight + 1], center=true);
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
  translate(tabPositiveY) {
    rotate([0, 0, 0]) {
      tab();
    }
  }
}
module tabNorth() {
  translate(tabNegativeY) {
    rotate([0, 0, 180]) {
      tab();
    }
  }
}
module tabEast() {
  translate(tabPositiveX) {
    rotate([0, 0, -90]) {
      tab();
    }
  }
}
module tabWest() {
  translate(tabNegativeX) {
    rotate([0, 0, 90]) {
      tab();
    }
  }
}


module slot() {
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
  translate(slotPositiveY) {
    rotate([0, 0, 180]) {
      slot();
    }
  }
}
module slotNorth() {
  translate(slotNegativeY) {
    rotate([0, 0, 0]) {
      slot();
    }
  }
}
module slotEast() {
  translate(slotPositiveX) {
    rotate([0, 0, 90]) {
      slot();
    }
  }
}
module slotWest() {
  translate(slotNegativeX) {
    rotate([0, 0, -90]) {
      slot();
    }
  }
}








scale(scale) {
  difference() {
    square();
    // Add slots here:
    slotSouth();
    slotNorth();
    slotEast();
    slotWest();
  }
  // Add tabs here:
  // tabSouth();
  // tabNorth();
  // tabEast();
  // tabWest();
}





