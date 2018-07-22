

(
// HAMBURG
~tempo = 270/120;


// Strings for display
~songEvents = [
	["MEL"],
	["MEL \n X", "MEL \n X++"],
	["RHYTM \n xxx", "RHYTM \n 4", "RHYTM \n 2/4"],
	[],
	["BLOW \n 4", "BLOW \n X"],
	[],
	["NOISE \n HIT"],
	["", "", "", "ECHO"]
];


~text;






//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 0
// OSC

Pdef(\in0,
	Pbind(\instrument, \space,
		\dur, 0.5,
		\note, Pseq([
			Pn(0, 16),
			Pn(3, 16),
			Pn(-4, 16),
			Pn(8, 16)
		], inf)-4,  // 4
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.8,
		\shift, 220,
		\out, i.inst0.index
)).quant_(4);

e[\in0Func1] = {
	Pbindef(\in0, \xamp, 1).reset.play;
};

e[\in0Func2] = {
};

e[\in0Func3] = {
};



// STOP PATTERN
e[\in0Func5] ={
	Pbindef(\in0).reset.stop;
};








//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 1
// MEL
Pdef(\in1,
	Pbind(\instrument, \space,
		\dur, 1, //Pseq([1, 0.5, 0.25, 0.25], inf),
		\freq, 170,
		\fb, Pkey(\dur)*1,
		\xamp, 0,
		\amp, Pkey(\xamp) * 1.99,
		\shift, 160,
		\out, i.inst1.index,
)).quant_(4);

e[\in1Func1] = {
	Pbindef(\in1, \xamp, 1,
		\dur, 1,
		\freq, 170,
		\rel, 0.2,
	).reset.play;
};

e[\in1Func2] = {
	Pbindef(\in1, \xamp, 1,
		\dur, Pseq([1, 0.5, 0.25, 0.25], inf),
		\freq, 120*3,
		\rel, 0.2,
	).reset.play;
};

e[\in1Func3] = {
};



// STOP PATTERN
e[\in1Func5] ={
	Pbindef(\in1).reset.stop;
};













//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 2
// SOUND
Pdef(\in2,
	Pbind(\instrument, \linz,
		\dur, 2, //Pseq([0.5, 0.5, 0.5, 0.25, 0.25, 1], inf),
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.4,
		\freq, 80,   // 80
		/*\freq, Pseq([
		Pn(80, 4),
			Pn(105, 2),
		Pn(60, 2),
		], inf),*/
		\ffreq, 30,
		\bfreq, 80,
		//\wn, Prand([0.1, 0.15, 0.3, 0.02], inf)/3,
		\wn, 0.2, // 0.9
		\filterFreq, 9300,
		\out, i.inst2.index,
)).quant_(4);


e[\in2Func1] = {
	Pbindef(\in2, \xamp, 1,
		\dur, Pseq([0.5, 0.5, 0.5, 0.25, 0.25, 1], inf),
	).reset.play;
};

e[\in2Func2] = {
	Pbindef(\in2, \xamp, 1,
		\dur, 1,
	).reset.play;
};

e[\in2Func3] = {
	Pbindef(\in2, \xamp, 1,
		\dur, 2,
	).reset.play;
};



// STOP PATTERN
e[\in2Func5] ={
	Pbindef(\in2).reset.stop;
};






//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 3


e[\in3Func1] = {
};

e[\in3Func2] = {
};

e[\in3Func3] = {
};




// STOP PATTERN
e[\in3Func5] ={
	Pbindef(\in3).reset.stop;
};










//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 4
// SOUND
Pdef(\in4,
	Pbind(\instrument, \quietsch,
		\dur, 0.5,
		//\dur, Pseq([0.125, 0.5, 0.5, 0.125, 0.25], inf),
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.1,
		\rel, 0.3,
		\freq, Pwhite(30, 800, inf),
		\out, i.inst4.index,
)).quant_(4);

e[\in4Func1] = {
	Pbindef(\in4, \xamp, 1,
		\dur, 0.5,
	).reset.play;
};


e[\in4Func2] = {
	Pbindef(\in4, \xamp, 1,
		\dur, Pseq([0.125, 0.5, 0.5, 0.125, 0.25], inf),
	).reset.play;
};

e[\in4Func3] = {};




// STOP PATTERN
e[\in4Func5] ={
	Pbindef(\in4).reset.stop;
};








//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 5


e[\in5Func1] = {
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
// NOISE
Pdef(\in6,
	Pbind(\instrument, \noiseRhythm,
		\dur, 2,
		\xamp, 0,
		\amp, Pkey(\xamp) * 1.8,
		\rel, 0.3, // 1,  // 1.9
		\freq, 11700,
		\out, i.inst6.index,
)).quant_([4, 1]).reset;

e[\in6Func1] = {
	Pbindef(\in6, \xamp, 1,
		\dur, 2,
	).reset.play;
};

e[\in6Func2] = {};

e[\in6Func3] = {};


// STOP PATTERN
e[\in6Func5] ={
	Pbindef(\in6).reset.stop;
};













)  // EOF