$fn=48;
module cross_slot(len,th,h=5){union(){cube([len,th,h],center=true);cube([th,len,h],center=true);}}
module test(x,tol){
  translate([x,0,0]) difference(){
    cylinder(d=9,h=6);
    translate([0,0,2.4]) cross_slot(4.03+2*tol,1.15+2*tol,5);
  }
}
hull(){translate([-14,0,0]) cylinder(d=11,h=1.2); translate([14,0,0]) cylinder(d=11,h=1.2);}
test(-14,0.05); test(0,0.10); test(14,0.15);
