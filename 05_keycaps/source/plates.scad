set = "full";
pitch=22;
module cap(file,x,y){ translate([x,y,0]) import(file); }
module row(file,n,y){ for(i=[0:n-1]) cap(file,(i-(n-1)/2)*pitch,y); }
module top10(){ row("../masters/DES_top.stl",10,0); }
module home10(){ row("../masters/DES_home.stl",10,0); }
module bottom10(){ row("../masters/DES_bottom.stl",10,0); }
module thumb5(){ row("../masters/DES_thumb.stl",5,0); }
module full35(){
 row("../masters/DES_top.stl",10,33);
 row("../masters/DES_home.stl",10,11);
 row("../masters/DES_bottom.stl",10,-11);
 row("../masters/DES_thumb.stl",5,-33);
}
if(set=="top10") top10();
if(set=="home10") home10();
if(set=="bottom10") bottom10();
if(set=="thumb5") thumb5();
if(set=="full") full35();
