width = inches(6);
margin = inches(5/8);
rounding = inches(1/2);
recess = inches(1/2);
legRadius = inches(3/16);
function inches (n) = n * 25.4;
function mid (n) = margin + inches(0.75 + n * 1.5);

module slot (height, x, y) {
    translate([mid(x), mid(y)])
        square([inches(7/8), inches(height)], true);
}

difference () {
    // TODO redo to ensure this is right. Maybe just us hull
    // to make sure it's correct.
    minkowski () {
        translate([rounding,rounding])
        square(width+margin*2-rounding*2);
        circle(rounding);
    } 
    
    layer2Slots();
    
    translate([width + margin + rounding - recess, recess])
    circle(legRadius);
    
    translate([recess, width + margin + rounding - recess])
    circle(legRadius);
    
    translate([width + margin + rounding - recess,
              width + margin + rounding - recess])
    circle(legRadius);
    
    translate([recess, recess])
    circle(legRadius);
}

// All are 3/4 inch deep
module layer1Slots () {
    union () {
        slot(1/2, 0, 3);
        slot(1/8, 1, 3);
        slot(1/8, 2, 3);
        slot(1/2, 3, 3);
    
        slot(1/2, 0, 2);
        slot(1/8, 1, 2);
        slot(1/8, 2, 2);
        slot(1/8, 3, 2);
    
        slot(1/2, 0, 1);
        slot(1,   1, 1);
        slot(1,   2, 1);
        slot(1/8, 3, 1);
    
        slot(1/8, 0, 0);
        slot(1/8, 1, 0);
        slot(1/8, 2, 0);
        slot(1/8, 3, 0);
    }
}

// Depth indicated if not 3/4 inch deep
module layer2Slots () {
    slot(1/2, 0, 3); // depth 9/16"
    slot(1/8, 1, 3);
    slot(1/8, 2, 3);
    slot(1/2, 3, 3);
    
    // same as layer 1
    slot(1/2, 0, 2); // depth 9/16"
    slot(1/8, 1, 2);
    slot(1/8, 2, 2);
    slot(1/2, 3, 2);
    
    // changed from layer1
    slot(1/2, 0, 1); // depth 9/16"
    slot(1,   1, 1); 
    slot(1,   2, 1);
    slot(1/8, 3, 1);
    
    // changed from layer1
    slot(1/2, 0, 0); // depth 9/16"
    slot(1/8, 1, 0); // depth 9/16"
    slot(1/8, 2, 0);
    slot(1/2, 3, 0);
}