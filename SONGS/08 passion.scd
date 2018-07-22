

(
// PASSION
~tempo = 249/120;


// Strings for display
~songEvents = [
	["OSC \n 1", "OSC \n up", "OSC \n fast"],
	["METAL \n 2", "METAL \n 4", "METAL \n RHYTM"],
	["RHYTM \n fast", "RHYTM \n damp", "RHYTM \n 4"],
	["OSC \n slow", "OSC \n fast"],
	[],
	["HH 8", "HH 4", "HH 8+f"],
	["KICK 2", "KICK 4"],
	["", "", "", "ECHO"]
];


~text;





//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 0
// SOUND

~passSynth = Synth(\passion1, [\out, i.inst0.index, \xamp, 0, \amp, 0.6], target:~synths);

e[\in0Func1] = {
	~passSynth.set(\xamp, 1, \freq, 20, \lf, 2);
};

e[\in0Func2] = {
	~passSynth.set(\xamp, 1, \freq, 120, \lf, 12);
};

e[\in0Func3] = {
	~passSynth.set(\xamp, 1, \freq, 50, \lf, 33);
};



// STOP PATTERN
e[\in0Func5] ={
	~passSynth.set(\xamp, 0);
};





//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 1
// QUIETSCH
Pdef(\in1,
	Pbind(\instrument, \quietsch,
		\dur, 4,
		\freq, Pwhite(112, 120, inf)*2,
		\rel, 2,
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.15,
		\out, i.inst1.index,
	);
).quant_(4);


e[\in1Func1] = {
	Pbindef(\in1, \xamp, 1,
		\dur, 4,
		\freq, Pwhite(112, 120, inf)*2,
		\rel, 2,
	).reset.play;
};


e[\in1Func2] = {
	Pbindef(\in1, \xamp, 1,
		\dur, 2,
		\freq, Pwhite(72, 120, inf)*2,
		\rel, 2,
	).reset.play;
};


e[\in1Func3] = {
	Pbindef(\in1, \xamp, 1,
		\dur, Pseq([2, 1, 4], inf)/2,
		\freq, Pwhite(60, 120, inf)*2,
		\rel, 2,
	).reset.play;
};


// STOP PATTERN
e[\in1Func5] ={
	Pbindef(\in1).reset.stop;
};







//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 2
// SOUND GAT
Pdef(\in2,
	Pbind(\instrument, \noiseRhythm,
		\dur, Pseq([0.25, 0.25, 0.5], inf),
		\xamp, 0,
		\amp, Pkey(\xamp) * 3.7,
		\freq, Pseq([2300, 3200, 4000], inf)*12,
		\rel, 0.2,
		\out, i.inst2.index,
)).quant_(4);

e[\in2Func1] = {
	Pbindef(\in2, \xamp, 1,
		\dur, Pseq([0.25, 0.25, 0.5], inf),
		\freq, Pseq([4300, 2200, 6000], inf)*3,
	).reset.play;
};


e[\in2Func2] = {
	Pbindef(\in2, \xamp, 1,
		\dur, Pseq([0.25, 0.25, 0.5], inf),
		\freq, Pseq([2300, 3200, 4000], inf)*4,
	).reset.play;
};


e[\in2Func3] = {
	Pbindef(\in2, \xamp, 1,
		\dur, Pseq([0.25, 0.25, 0.25], inf)*4,
		\freq, Pseq([2300, 3200, 5000], inf)*4,
	).reset.play;
};


// STOP PATTERN
e[\in2Func5] ={
	Pbindef(\in2).reset.stop;
};




//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 3
// SOUND

~passXSynth = Synth(\passion2, [\out, i.inst3.index, \xamp, 0, \amp, 0.8], target:~synths);

e[\in3Func1] = {
	~passXSynth.set(\xamp, 1, \freq, 20, \lf, 12 , \fb, 1.6);
};

e[\in3Func2] = {
	~passXSynth.set(\xamp, 1, \freq, 20, \lf, 3 , \fb, 3.6);
};

e[\in3Func3] = {
};



// STOP PATTERN
e[\in0Func5] ={
	~passXSynth.set(\xamp, 0);
};








//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 4



e[\in4Func1] = {
};

e[\in4Func2] = {
};

e[\in4Func3] = {
};




// STOP PATTERN
e[\in4Func5] ={
	Pbindef(\in4).reset.stop;
};




















//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 5
// HH
Pdef(\in5,
	Pbind(\instrument, \hh1,
		\dur, 0.25,
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.9,
		\time, 0.5,
		\rel, 0.03,
		//\hp, 9000,
		\out, i.inst5.index,
)).quant_(4);


e[\in5Func1] = {
	Pbindef(\in5, \xamp, 1,
		\dur, 0.25,
		\hp, 3000,
	).reset.play;
};

e[\in5Func2] = {
	Pbindef(\in5, \xamp, 1,
		\dur, 0.5,
		\hp, 3000,
	).reset.play;
};


e[\in5Func3] = {
	Pbindef(\in5, \xamp, 1,
		\dur, 0.25,
		\hp, Pwhite(4000, 10000, inf),
	).reset.play;
};



// STOP PATTERN
e[\in5Func5] ={
	Pbindef(\in5).reset.stop;
};






//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 6
// KICK
Pdef(\in6,
	Pbind(\instrument, \kick,
		\dur, 1,
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.5,
		\bd, Pwhite(0.8, 1.1, inf),
		\out, i.inst6.index,
)).quant_(4);


e[\in6Func1] ={
	Pbindef(\in6, \xamp, 1,
		\dur, 1,
	).reset.play;
};


e[\in6Func2] ={
	Pbindef(\in6, \xamp, 1,
		\dur, 0.5,
	).reset.play;
};

e[\in6Func3] = {};



// STOP PATTERN
e[\in6Func5] ={
	Pbindef(\in6).reset.stop;
};









)  // END OF PATCH