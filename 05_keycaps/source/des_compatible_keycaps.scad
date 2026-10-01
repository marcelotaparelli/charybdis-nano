$fn=64;
profile="top";

module rr2d(w,d,r){ offset(r=r) square([w-2*r,d-2*r],center=true); }
module slab(w,d,r,z,shift=0,ang=0,t=0.35){
  translate([0,shift,z]) rotate([ang,0,0]) linear_extrude(height=t,center=true) rr2d(w,d,r);
}
module frustum(bw,bd,tw,td,br,tr,h,shift,ang){
  hull(){ slab(bw,bd,br,0.2,0,0,0.4); slab(tw,td,tr,h-0.2,shift,ang,0.4); }
}
module cross_slot(len=4.25,th=1.35,h=5){
 union(){cube([len,th,h],center=true); cube([th,len,h],center=true);} }
module keycap(h=10.5,ang=9,shift=1.1,dish=1.5,saddle=false){
  bw=17.2; bd=17.2; tw=12.2; td=12.2;
  wall=1.7; topth=2.0;
  difference(){
    union(){
      difference(){
        frustum(bw,bd,tw,td,1.6,2.0,h,shift,ang);
        translate([0,0,-0.4]) frustum(bw-2*wall,bd-2*wall,tw-2*wall,td-2*wall,1.0,1.3,h-topth+0.6,shift*0.72,ang*0.72);
      }
      // MX stem boss attached to roof
      cylinder(d=6.6,h=h-topth+0.7);
    }
    // dish cut
    if(saddle){
      translate([0,0,h+18-dish]) rotate([0,90,0]) cylinder(r=18,h=40,center=true);
    } else {
      translate([0,0,h+24-dish]) sphere(r=24);
    }
    // female MX cross
    translate([0,0,2.0]) cross_slot(4.25,1.35,4.6);
  }
}
if(profile=="top") keycap(h=10.55,ang=9,shift=1.0,dish=1.6);
if(profile=="home") keycap(h=8.75,ang=4,shift=.5,dish=1.7);
if(profile=="bottom") keycap(h=9.75,ang=-13,shift=-1.2,dish=1.6);
if(profile=="thumb") keycap(h=8.4,ang=-3,shift=-.3,dish=1.8,saddle=true);
