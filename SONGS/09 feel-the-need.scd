
(
// FEEL THE NEED
~tempo = 200/120;


// Strings for display
~songEvents = [
	["BASS \n fill"],
	["", "", "", "SOLO"],
	["BASS \n flat", "BASS \n X", "BASS  XX"],
	[],
	["SNARE"],
	["HH perc", "HH click"],
	["KICK"],
	["", "", "", "ECHO"]
];


~text;





//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 0
// BASS FILL
Pdef(\in0,
	Pbind(\instrument, \samplerStereo2,
		\bufnum, Pseq([
			a[\bass][0].bufnum
		], inf),
		\dur, 1,
		\rate, 0.4,
		\xamp, 0,
		\amp, Pkey(\xamp) * 1.0,
		\out, i.inst0.index,
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
// SOLO

e[\in1Func1] = {
};

e[\in1Func2] = {
};

e[\in1Func3] = {
};


// STOP PATTERN
e[\in1Func5] ={
	Pbindef(\in1).reset.stop;
};


////////////////////////////////////////////////
// SCALE

10.do({|n|
	var freq;    // = (20 * n)+600;
	var scale, scaleSize;
	var octave=1, rootFreq, degree;
	var post;
	scale = Scale.minor;
	scaleSize = scale.size;
	octave = 1;
	rootFreq = 80;
	degree = n;
	freq = scale.degreeToFreq(degree, rootFreq, octave);
	//[n, freq, octave].postln;

	e[("num"++n++"DownFunc").asSymbol] = {
		//[n, freq].postln;

		Synth(\shapePerc, [
			\freq, freq*6,
			\atk, 0.2,
			\rel, 1.2,
			\amp, 0.15,
			\out, i.inst1.index,
		])
	};
});






//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 2
// BASS SSSS
Pdef(\in2,
	Pbind(\instrument, \shape,
		\dur, 0.5,
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.5,
		\freq, Pseq([
			Pseq([120, 125], 3),
			//Pseq([220, 225]*2, 1),
		], inf)*1,
		\legato, 1,
		\out, i.inst2.index,
)).quant_(4);

// 2 Tones basic
e[\in2Func1] = {
	Pbindef(\in2, \xamp, 1,
		\freq, Pseq([
			Pseq([120, 125], 3),
			//Pseq([220, 225]*2, 1),
		], inf)*0.4,
	).reset.play;
};


// 2 Tones + HIGH
e[\in2Func2] = {
	Pbindef(\in2, \xamp, 1,
		\freq, Pseq([
			Pseq([120, 125], 3),
			Pseq([220, 225]*1.8, 1),
		], inf)*0.6,
	).reset.play;
};

e[\in2Func3] = {
	Pbindef(\in2, \xamp, 1,
		\freq, Pseq([
			Pseq([120, 125], 3),
			Pseq([220, 225]*2, 1),
		], inf)*0.8,
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
Pdef(\in4,
	Pbind(\instrument, \samplerMono,
		\bufnum, Pseq([
			a[\snare][2].bufnum
		], inf),
		\dur, 2,
		\rate, 1.3,
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.7,
		\out, i.inst4.index,
)).quant_([4, 3]).reset;

e[\in4Func1] = {
	Pbindef(\in4, \xamp, 1,
		\dur, 2,
		\rate, 1.3,
	);
	Pdef(\in4).quant_([4, -3]).reset.play;
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
		\bufnum, Pseq([
			a[\hh][0].bufnum
		], inf),
		\dur, 1,
		\rate, 0.4,
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.4,
		\out, i.inst5.index,
)).quant_([4, 0]).reset;


e[\in5Func1] = {
	Pbindef(\in5, \xamp, 1,
		\bufnum, Pseq([
			a[\hh][0].bufnum
		], inf),
		\dur, Pseq([
			Pn(1, 6),
			Pn(0.25, 4),
		], inf),
		\rate, 0.4,
		\amp, Pkey(\xamp) * 0.5,
).reset.play;

};

e[\in5Func2] = {
	Pbindef(\in5, \xamp, 1,
		\bufnum, Pseq([
			a[\hh][2].bufnum
		], inf),
		\dur, Pseq([
			Pn(0.125, 4),
			Pn(1, 1),
			Pn(0.25, 7),
			Pn(0.5, 5),
		], inf),
		\rate, 1.4,
		\amp, Pkey(\xamp) * 4,
).reset.play;
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
	Pbind(\instrument, \samplerStereo2,
		\bufnum, Pseq([
			a[\kick][2].bufnum,
			a[\kick][3].bufnum,
			a[\kick][4].bufnum
		], inf),
		\dur, Pseq([
			Pn(1, 4),
			1, 0.5, 0.5], inf),
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.75,
		\out, i.inst6.index,
)).quant_(4);

e[\in6Func1] ={
	Pbindef(\in6, \xamp, 1).reset.play;
};

e[\in6Func2] ={

};

e[\in6Func3] ={

};


// STOP PATTERN
e[\in6Func5] ={
	Pbindef(\in6).reset.stop;
};













) // END OF FILE

