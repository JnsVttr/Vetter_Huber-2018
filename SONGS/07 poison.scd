


(
// POISON
~tempo = 246/120;


// Strings for display
~songEvents = [
	["MEL \n deep", "MEL \n +++", "MEL \n high"],
	["PERC"],
	["BASS \n 1", "BASS \n 2", "BASS \n 3"],
	["STRING \n 1", "STRING \n 2", "STRING \n deep"],
	["SNARE"],
	["HH 4", "HH 8"],
	["KICK 4", "KICK \n break 8", "KICK \n break 16"],
	["", "", "", "ECHO"]
];


~text;






//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 0
// Bass
Pdef(\in0,
	Pbind(\instrument, \linz,
		\dur, 0.5,
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.4,
		\freq, Pseq([60, 90, 110, 140], inf),
		\wn, Prand([0.1, 0.2, 0.5], inf),
		\rel, 0.2,
		\out, i.inst0.index,
)).quant_(4);


e[\in0Func1] = {
	Pbindef(\in0, \xamp, 1,
		\dur, Pseq([1, 1, 0.25, 0.5, 1.25], inf),
		\ds, 2.5,
		\rel, Prand([0.2, 0.3, 0.1], inf),
		\freq, Pseq([30, 30, 30, 30, 30, 30, Prand([38, 24])], inf)*7,
		\ffreq, Prand([300, 600, 800, 830]/2, inf),
		\bfreq, 70
	).reset.play;
};

e[\in0Func2] = {
	Pbindef(\in0, \xamp, 1,
		\dur, Pseq([1, 1, 0.25, 0.5, 1.25], inf),
		\ds, 2.5,
		\rel, Prand([0.2, 0.3, 0.1], inf),
		\freq, Pseq([30, 30, 30, 30, 30, 30, Prand([38, 24])], inf)*9,
		\ffreq, Prand([300, 600, 800, 830]/2, inf),
		\bfreq, 70
	).reset.play;
};


e[\in0Func3] = {
	Pbindef(\in0, \xamp, 1,
		\dur, Pseq([1, 1, 0.25, 0.5, 1.25], inf)*1,
		\ds, 2.5,
		\rel, Prand([0.2, 0.3, 0.1], inf),
		\freq, Pseq([30, 30, 30, 30, 30, 30, Prand([38, 24])], inf)*12,
		\ffreq, Prand([300, 600, 800, 830]/2, inf),
		\bfreq, 70
	).reset.play;
};



// STOP PATTERN
e[\in0Func5] ={
	Pbindef(\in0).reset.stop;
};









//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 1
// NOISE
Pdef(\in1,
	Pbind(\instrument, \noise,
		\dur, 4,
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.5,
		\level, 2,
		\lp, 5000,
		\time, 1,
		\out, i.inst1.index,
)).quant_(4);

e[\in1Func1] = {
	Pbindef(\in1, \xamp, 1,).reset.play;
};

e[\in1Func2] = {
};

e[\in1Func3] = {
};


// STOP PATTERN
e[\in1Func5] ={
	Pbindef(\in1).reset.stop;
};














//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 2
// Bass
Pdef(\in2,
	Pbind(\instrument, \linz,
		\dur, 0.5,
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.4,
		\freq, Pseq([60, 90, 110, 140], inf),
		\wn, Prand([0.1, 0.2, 0.5], inf),
		\rel, 0.2,
		\out, i.inst2.index,
)).quant_(4);

e[\in2Func1] = {
	Pbindef(\in2, \xamp, 1,
		//\dur, Pseq([1, 1, 0.5, 0.25, 0.25, 1], inf),
		\dur, 0.25,
		\ds, 1.0,
		\rel, Prand([0.2, 0.3, 0.1], inf),
		\freq, Pseq([50], inf),
		\ffreq, Prand([300, 600, 800, 830]/4, inf),
		\bfreq, 70
	).reset.play;
};


e[\in2Func2] = {
	Pbindef(\in2, \xamp, 1,
		//\dur, Pseq([1, 1, 0.5, 0.25, 0.25, 1], inf),
		\dur, 0.25,
		\ds, 1.0,
		\rel, Prand([0.2, 0.3, 0.1], inf),
		\freq, Pseq([60], inf),
		\ffreq, Prand([300, 600, 800, 830]/4, inf),
		\bfreq, 70
	).reset.play;
};


e[\in2Func3] = {
	Pbindef(\in2, \xamp, 1,
		//\dur, Pseq([1, 1, 0.5, 0.25, 0.25, 1], inf),
		\dur, 0.25,
		\ds, 1.0,
		\rel, Prand([0.2, 0.3, 0.1], inf),
		\freq, Pseq([40], inf),
		\ffreq, Prand([300, 600, 800, 830]/4, inf),
		\bfreq, 70
	).reset.play;
};




// STOP PATTERN
e[\in2Func5] ={
	Pbindef(\in2).reset.stop;
};










//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 3
// SHAPE
Pdef(\in3,
	Pbind(\instrument, \shape,
		\dur, 0.5,
		\freq, Pseq([180, 190, 230, Prand([320, 430], 1)], inf),
		\legato, 1,
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.4,
		\out, i.inst3.index,
)).quant_(4);

e[\in3Func1] = {
	Pbindef(\in3, \xamp, 1,
		\dur, 0.5,
		\freq, Pseq([180, 190, 230, Prand([320, 430], 1)], inf),
	).reset.play;
};

e[\in3Func2] = {
	Pbindef(\in3, \xamp, 1,
		\dur, 0.5,
		\freq, Pseq([580, 190, 230, Prand([520, 610], 1)], inf),
	).reset.play;
};

e[\in3Func3] = {
	Pbindef(\in3, \xamp, 1,
		\dur, 2,
		\freq, Pseq([80, 60, 30, Prand([90, 110], 1)], inf),
	).reset.play;
};



// STOP PATTERN
e[\in3Func5] ={
	Pbindef(\in3).reset.stop;
};












//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 4
// SNARE
Pdef(\in4,
	Pbind(\instrument, \samplerMono,
		\bufnum, Pseq([
			a[\snare][1].bufnum
		], inf),
		\dur, 2,
		\rate, 1.1,
		\xamp, 0,
		\amp, Pkey(\xamp) * 1.5,
		\out, i.inst4.index,
)).quant_([4, 1]);


e[\in4Func1] = {
	Pbindef(\in4, \xamp, 1,
		\dur, 2,
		\rate, 1.2,
	).reset.play;
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
Pdef(\in5,
	Pbind(\instrument, \hh1,
		\dur, 0.5,
		\rel, 0.2,
		\xamp, 0,
		\amp, Pkey(\xamp) * 1.2,
		\out, i.inst5.index,
)).quant_(4);

e[\in5Func1] = {
	Pbindef(\in5, \xamp, 1,
		\dur, 0.5,
	).reset.play;
};

e[\in5Func2] = {
	Pbindef(\in5, \xamp, 1,
		\dur, 0.25,
	).reset.play;
};

e[\in5Func3] = {};



// STOP PATTERN
e[\in5Func5] ={
	Pbindef(\in5).reset.stop;
};




//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 6
// KICK
Pdef(\in6,
	Pbind(\instrument, \kickDesert,
		\dur, 1,
		\xamp, 0,
		\amp, Pkey(\xamp) * Pwhite(0.8, 0.9, inf)*1.2,
		\bd, Prand([0.3, 0.4, 0.36, 0.28]*2.3, inf),
		\out, i.inst6.index,
)).quant_(4);

e[\in6Func1] ={
	Pbindef(\in6, \xamp, 1,\dur, 1,).reset.play;
};

e[\in6Func2] ={
	Pbindef(\in6, \xamp, 1,
		\dur, Pseq([1, 1, Pn(0.25, 4), Pn(0.5, 2)], inf)
	).reset.play;
};

e[\in6Func3] ={
	Pbindef(\in6, \xamp, 1,
		\dur, Pseq([Pn(0.25, 4), Pn(0.5, 4)], inf),
	).reset.play;
};





// STOP PATTERN
e[\in6Func5] ={
	Pbindef(\in6).reset.stop;
};











) // EOF
