(
//////////////////////////////////////////////
// PERFORM ON STOP
if (~system==true, {
// stop PDEFs
Pdef.all.do{|c| c.postln; c.stop}; //Pdef.removeAll;

// free all Synths
~synths.freeAll;

// reset text


});


)