

(
// KARMA
~tempo = 123/60;


// Strings for display
~songEvents = [
	["MEL \n part"],
	["BASS  high"],
	["BASS deep"],
	["TRAIN", "TRAIN fast"],
	["SWING"],
	["BOW   click"],
	["RHYTM"],
	["", "", "", "ECHO"]
];


~text;






//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 0
// BASS FILL
Pdef(\in0, Pbind(
	\instrument, \loc,
	\dur, 0.5,
	\rel, 0.2,
	\amp, 0.5,
	\freqMul, Pseq([
		Pn(2, 2),
		Pwhite(3.0, 4.0, 2),
		Pn(1, 4),
	], 4),
	\xamp, 0,
	\out, i.inst0.index,
)).quant_(4);



e[\in0Func1] = {
	Pbindef(\in0, \xamp, 1).reset.play;
};

e[\in0Func2] = {};

e[\in0Func3] = {};




// STOP PATTERN
e[\in0Func5] ={
	Pbindef(\in0).reset.stop;
};






//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 1
// BASS HIGH
Pdef(\in1, Pbind(
	\instrument, \ka,
	\dur, 0.25,
	\rel, 0.4,
	\fb, Pfunc({b[\kn1].get({|el| el.linlin(0, 1, 0.2, 0.7)})}),
	\hp, 80,
	\freqMul, Pseq([
		0.6,
		Pseq([0.25, 0.3, 0.18, 0.34, 0.28], 4)
	], inf)*3.02,
	\amp, Pseq([0.7, Pn(0.5, 20)], inf)*1.5,
	\xamp, 0,
	\out, i.inst1.index,
)).quant_(4);



e[\in1Func1] = {
	Pbindef(\in1, \xamp, 1).reset.play;
};

e[\in1Func2] = {};

e[\in1Func3] = {};

/*
b[\kn1].get({|el| el.linlin(0, 1, 0.2, 0.7).postln})
*/


// STOP PATTERN
e[\in1Func5] ={
	Pbindef(\in1).reset.stop;
};





//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 2
// bassline
Pdef(\in2, Pbind(
	\instrument, \ka,
	\dur, 0.25,
	\rel, 0.3,
	\amp, 1.1,
	\lp, 7900,
	\fb, Pfunc({b[\kn2].get({|el| el.linlin(0, 1, 0.2, 0.7)})}),
	\freqMul, Pseq([
		0.6,
		Pseq([0.25, 0.3, 0.18, 0.34, 0.28], 4)
	], inf)*1.2,
	\xamp, 0,
	\out, i.inst2.index,
)).quant_(4);


e[\in2Func1] = {
	Pbindef(\in2, \xamp, 1).reset.play;
};

e[\in2Func2] = {};

e[\in2Func3] = {};


// STOP PATTERN
e[\in2Func5] ={
	Pbindef(\in2).reset.stop;
};




//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 3
// SOUND
Pdef(\in3, Pbind(
	\instrument, \shockKlank,
	\dur, 16, //Prand([8, 16, 24], inf),
	\freq, 180,
	\atk, 1,
	\rel, 14,
	\amp, 0.8,
	\xamp, 0,
	\out, i.inst3.index,
)).quant_(4).reset;


e[\in3Func1] = {
	Pbindef(\in3, \xamp, 1, \freq, 180).reset.play;
};

e[\in3Func2] = {
	Pbindef(\in3, \xamp, 1, \freq, [220, 120, 90, 320]).reset.play;
};

e[\in3Func3] = {};



// STOP PATTERN
e[\in3Func5] ={
	Pbindef(\in3).reset.stop;
};






//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 4
// SNARE/ SWING
Pdef(\in4, Pbind(
	\instrument, \locWide,
	\dur, 4,
	\rel, 2,
	\amp, 0.6,
	\freqMul, 1,
	\xamp, 0,
	\out, i.inst4.index,
)).quant_(4).reset;


e[\in4Func1] = {
	Pbindef(\in4, \xamp, 1,).reset.play;
};

e[\in4Func2] = {};

e[\in4Func3] = {};



// STOP PATTERN
e[\in4Func5] ={
	Pbindef(\in4).reset.stop;
};






//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 5
// HH
// high pitch tom hits
Pdef(\in5, Pbind(
	\instrument, \bow,
	\dur, Pseq([
		Pn(0.25, 16),
		Pn(2, 4)  // 10
	], inf),
	\rel, 0.2,
	\amp, 0.2,
	\freqMul, 0.2,
	\xamp, 0,
	\out, i.inst5.index,
)).quant_(4);



e[\in5Func1] = {
	Pbindef(\in5, \xamp, 1).reset.play;
};

e[\in5Func2] = {
};

e[\in5Func3] = {
};



// STOP PATTERN
e[\in5Func5] ={
	Pbindef(\in5).reset.stop;
};




//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 6
// KICK
Pdef(\in6, Pbind(
	\instrument, \shock,
	\dur, 0.25,
	\rel, 0.1,
	\amp, 0.99,
	\freq, 130,
	\gray, Pwhite(0.1, 0.2, inf),
	\pan, 1,
	\xamp, 0,
	\out, i.inst6.index,
)).quant_(4);

Pdef(\in6Hit, Pbind(
	\instrument, \shock,
	\dur, 2,
	\rel, 0.1,
	\gray, 0.4,
	\amp, 1,
	\freq, 110,
	\pan, -1,
	\xamp, 0,
	\out, i.inst6.index,
)).quant_(4);



e[\in6Func1] ={
	Pbindef(\in6, \xamp, 1).reset.play;
	Pbindef(\in6Hit, \xamp, 1).reset.play;
};

e[\in6Func2] = {};

e[\in6Func3] = {};




// STOP PATTERN
e[\in6Func5] ={
	Pbindef(\in6).reset.stop;
};







) // END OF FILE

