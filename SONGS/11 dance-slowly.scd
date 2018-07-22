


(
// DANCE SLOWLY
~tempo = 220/120;


// Strings for display
~songEvents = [
	["SAMPLE \n 4", "SAMPLE \n 4++", "SAMPLE \n 4 mel"],
	["STRING", "STRING \n fast"],
	["BASS \n 1", "BASS \n 1 fast", "BASS \n song"],
	[],
	["SNARE"],
	["HH 8"],
	["KICK 2", "KICK \n fill"],
	["", "", "", "ECHO"]
];


~text;





//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 0
// STRING  MELODIE

Pdef(\in0, Pbind(\instrument, \grain2,
	\bufnum, a[\string][1].bufnum,
	\dur, 0.5,
	\xamp, 0,
	\amp, Pkey(\xamp) * 0.9,
	\startPos, 3000,
	\rate, 3,
	\rel, 0.5,
	\freq, 12000,
	\out, i.inst0.index,
)).quant_([4, 0.47]);


e[\in0Func1] = {
	Pbindef(\in0, \xamp, 1,
		\rate, 3,
	).reset.play;
};

e[\in0Func2] = {
	Pbindef(\in0, \xamp, 1,
		\rate, Pwhite(3, 3.3, inf),
	).reset.play;
};

e[\in0Func3] = {
	Pbindef(\in0, \xamp, 1,
		\rate, Pseq([
			Pn(3, 4),
			Pn(3.5, 2),
			Pn(3.9, 2),
		], inf),
	).reset.play;
};


// STOP PATTERN
e[\in0Func5] ={
	Pbindef(\in0).reset.stop;
};





//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 1
// STRING
x.time = Plazy({
	Pseq([
		Pseq([1, 1.2, 1.4, 1.5], 2)*1.0,
		Pseq([1, 1.2, 1.9, 1.5], 1)*1.2,
		Pseq([1, 1.2, 1.9, 1.5], 1)*1.5,
	], inf)
});
Pdef(\in1, Pbind(\instrument, \grain2,
	\bufnum, a[\bass][6].bufnum,
	\dur, 0.5,
	\xamp, 0,
	\amp, Pkey(\xamp) * 0.9,
	\startPos, 3000,
	\rate, x.time*1.0,
	\rel, 0.5,
	\freq, 12000,
	\out, i.inst1.index,
)).quant_([4, 1.47]);


e[\in1Func1] = {
	Pbindef(\in1, \xamp, 1,
		\dur, 0.5,
	).reset.play;
};

e[\in1Func2] = {
	Pbindef(\in1, \xamp, 1,
		\dur, 0.25,
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
// BASS
x.time = Plazy({
		Pseq([
			Pseq([1, 1.2, 1.4, 1.5], 2)*1.0,
			Pseq([1, 1.2, 1.9, 1.5], 1)*1.2,
			Pseq([1, 1.2, 1.9, 1.5], 1)*1.5,
		], inf)
	});
Pdef(\in2,
	Pbind(\instrument, \grain2,
		\bufnum, a[\bass][1].bufnum,
		\dur, 0.5,
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.9,
		\startPos, 3000,
		\rate, x.time*1.0,
		\rel, 0.5,
		\freq, 12000,
		\out, i.inst2.index,
)).quant_([4, 1.47]);


e[\in2Func1] = {
	Pbindef(\in2, \xamp, 1,
		\dur, 0.5,
		\rate, x.time*1.0  // 1, 1.2
	).reset.play;
};

e[\in2Func2] = {
	Pbindef(\in2, \xamp, 1,
		\dur, 0.25,
		\rate, x.time*1.0  // 1, 1.2
	).reset.play;
};

e[\in2Func3] = {
	Pbindef(\in2, \xamp, 1,
		\dur, 0.25,
		\rate, Pseq([
			Pn(1, 16),
			Pn(1.2, 8),
			Pn(0.9, 8),
			Pn(1, 8),
		], inf),  // 1, 1.2
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
// SNARE
x.snare = Plazy ({Pseq([2], inf)});
Pdef(\in4,
	Pbind(\instrument, \samplerMono,
		\bufnum, a[\snare][1].bufnum,
		\dur, x.snare,
		\xamp, 0,
		\amp, Pkey(\xamp) * 1.5,
		\rate, 1.1,
		\out, i.inst4.index,
)).quant_([4, 1.01]);

e[\in4Func1] = {
	Pbindef(\in4, \xamp, 1).reset.play;
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
	Pbind(\instrument, \samplerStereo2,
		\bufnum, a[\hh][0].bufnum,
		\dur, Pseq([
			Pn(1, 14),
			Pn(0.25, 4),
		], inf)*0.5,
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.9,
		\rate, Pwhite(1, 1.2, inf)*2,
		\out, i.inst5.index,
)).quant_([4, 0.45]);

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
Pdef(\in6,
	Pbind(\instrument, \kickDesert,
		\dur, 1,
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.6,
		\bd, 0.9,
		\out, i.inst6.index,
)).quant_(4);


e[\in6Func1] ={
	Pbindef(\in6, \xamp, 1,
		\dur, Pseq([Pn(1, 8), Pn(0.5, 2)], inf),
	).reset.play;
};


e[\in6Func2] ={
	Pbindef(\in6, \xamp, 1,
		\dur, Pseq([0.5, Pn(1, 2)], inf),
	).reset.play;
};

e[\in6Func3] ={
};



// STOP PATTERN
e[\in6Func5] ={
	Pbindef(\in6).reset.stop;
};










) // EOF



