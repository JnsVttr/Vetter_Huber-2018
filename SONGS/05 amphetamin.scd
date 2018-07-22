(
// AMPHETAMIN
~tempo = 100/60;


// Strings for display
~songEvents = [
	["NOISE"],
	["", "", "", "SOLO"],
	["BASS", 		"BASS \n mel",		"BASS \n intro"],
	["MEL \n fill", nil, "MEL \n fast"],
	["SNARE"],
	["HH", 		"HIT"],
	["KICK 4/4"],
	["", "", "", "ECHO"]
];


~text;






//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 0
// Background Noise
Pdef(\in0, Pbind(
	\instrument, \samplerStereo,
	\bufnum, a[\noise].[0].bufnum,
	\rel, 4,
	\rate, Pwhite(0.7, 1, inf),
	\startPos, Pseq([23000, 800000, 1000000, 2000000, 8000000], inf),
	\lp, 3000,
	\dur, 4,
	\amp, 2.7,
	\xamp, 0,
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

		Synth(\shapePercSin, [
			\freq, freq*6,
			\atk, 0.2,
			\rel, 0.2,
			\amp, 0.15,
			\out, i.inst1.index,
		])
	};
});







//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 2
// Bass Line
Pdef(\in2, Pbind(
	\instrument, \samplerStereo,
	\bufnum, Pseq([
		Pn(a[\VH_bass].[18].bufnum, 8),
		Pn(a[\VH_bass].[17].bufnum, 2),
		Pn(a[\VH_bass].[16].bufnum, 2),
		Pn(a[\VH_bass].[15].bufnum, 2),
		Pn(a[\VH_bass].[14].bufnum, 2)
	],inf),  // 13 deep
	\pan, Prand([-0.7, 0.7, 0], inf),
	\rate, 0.8, // pitch
	\startPos, 1000,
	\lp, 12000,
	\rev, 0,
	\dur, 0.25,
	\rel, Pkey(\dur)*2.3,
	\amp, 3.7,
	\xamp, 0,
	\out, i.inst2.index,
)).quant_(4);

// Solo Bass Line
Pdef(\in2Solo, Pbind(
	\instrument, \samplerStereo,
	\bufnum, Pseq([
		Pn(a[\VH_bass].[18].bufnum, 12),
		//Pn(a[\VH_bass].[17].bufnum, 2),
		Pn(a[\VH_bass].[16].bufnum, 1),
		Pn(a[\VH_bass].[15].bufnum, 1),
		Pn(a[\VH_bass].[14].bufnum, 2)
	],inf),  // 13 deep
	\pan, Prand([-0.7, 0.7, 0], inf),
	\rate, Pseq([
		Pseq([Pn(0.7, 16)], 2),
		Pseq([Pn(0.9, 16)], 2),
		Pseq([Pn(0.7, 16)], 2),
		Pseq([Pn(1.05, 16)], 1),
		Pseq([Pn(1.2, 8)], 1),
		Pseq([Pn(1.3, 4)], 1),
		Pseq([Pn(1.5, 4)], 1),
	], inf)*1.3, // pitch
	\startPos, 1000,
	\lp, 12000,
	\rev, 0,
	\dur, 0.25,
	\rel, Pkey(\dur)*2.3,
	\amp, 2.7,
	\xamp, 0,
	\out, i.inst2.index,
)).quant_(4);


// BASS
e[\in2Func1] = {
	Pdef(\in2).stop;
	Pbindef(\in2Solo, \xamp, 1, \rate, 1.3).reset.play;
};

e[\in2Func2] = {
	Pdef(\in2).stop;
	Pbindef(\in2Solo, \xamp, 1,
		\rate, Pseq([
		Pseq([Pn(0.7, 16)], 2),
		Pseq([Pn(0.9, 16)], 2),
		Pseq([Pn(0.7, 16)], 2),
		Pseq([Pn(1.05, 16)], 1),
		Pseq([Pn(1.2, 8)], 1),
		Pseq([Pn(1.3, 4)], 1),
		Pseq([Pn(1.5, 4)], 1),
	], inf)*1.3, // pitch
	).reset.play;
};

// INTRO
e[\in2Func3] = {
	Pdef(\in2Solo).stop;
	Pbindef(\in2, \xamp, 1, \rate, 1).reset.play;
};



// STOP PATTERN
e[\in2Func5] ={
	Pbindef(\in2).reset.stop;
};






//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 3
// Bass Line Fill
Pdef(\in3, Pbind(
	\instrument, \samplerStereo,
	\bufnum, Pseq([
		Pn(a[\VH_bass].[18].bufnum, 8),
		Pn(a[\VH_bass].[17].bufnum, 2),
		Pn(a[\VH_bass].[16].bufnum, 2),
		Pn(a[\VH_bass].[15].bufnum, 2),
		Pn(a[\VH_bass].[14].bufnum, 2)
	],inf),  // 13 deep
	\rate, Pgeom(32.8, 0.94, 64),
	\pan, Pwhite(-1, 1, inf),
	\startPos, 1000,
	\lp, 9000,
	\hp, 100,
	\rev, 0,
	\dur, 0.125,
	\rel, Pkey(\dur)*1,
	\amp, 2,
	\xamp, 0,
	\out, i.inst3.index,
)).quant_(4);


// Melody
Pdef(\in3Mel, Pbind(
	\instrument, \samplerStereo,
	\bufnum, a[\VH_bass].[4].bufnum,
	\rel, 2,
	//\rate, Pseq([4, 4.8, Pn(Pwhite(6, 8, 1), 6)], 4)*2,
	\rate, Pseq([
		4.1, 4.8,
		Pseq([6.2, 7, 8], 2),
		4.1, 4.8,
		Pseq([8.2, 7.2, 6], 2),
		4.1, 4.8,
		Pseq([8.2, 9.2, 6.1], 2)
	], inf)*2,
	\lp, 13000,
	\rev, 0.4,
	\dur, Pseq([
		1, 1,
		Pn(0.25, 4),
		Pn(0.5, 2)
	], inf),
	\amp, 3,
	\xamp, 0,
	\out, i.inst3.index,
));

// MEL FILL
e[\in3Func1] = {
	Pdef(\in3).stop;
	Pbindef(\in3Mel, \xamp, 1).quant_(4).reset.play;
};

e[\in3Func2] = {
};

// FAST
e[\in3Func3] = {
	Pdef(\in3Mel).stop;
	Pbindef(\in3, \xamp, 1, \rate, 3).reset.play;
};

e[\in3Func2] = {
	Pdef(\in3Mel).stop;
	Pbindef(\in3, \xamp, 1, \rate, 3).reset.play;
};




// STOP PATTERN
e[\in3Func5] ={
	Pbindef(\in3).reset.stop;
};










//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 4
// SNARE
Pdef(\in4, Pbind(
	\instrument, \samplerMono,
	\bufnum, a[\drum_SN].[4].bufnum,
	\rate, Pwhite(0.8, 1.02, inf),
	\lp, 5000,
	\dur, 2,
	\amp, 1.8,
	\xamp, 0,
	\out, i.inst4.index,
)).quant_([4, 1]);

e[\in4Func1] = {
	Pbindef(\in4, \xamp, 1,).quant_([4, -3]).reset.play;
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
Pdef(\in5, Pbind(
	\instrument, \samplerMono,
	\bufnum, a[\drum_HAT].[3].bufnum,
	\rate, 0.8,
	\dur, Pseq([
		Pn(0.25, 16),
		Pn(0.125, 5), 0.25, 0.125,
		Pn(0.25, 12),
	], inf),
	\lp, 3000,
	//\amp, Pwhite(0.01, 0.3, inf),
	\amp, Pif(Pkey(\dur)<0.25, 0.7, Pwhite(0.05, 0.2, inf)+0.7)*1.3,
	\xamp, 0,
	\out, i.inst5.index,
)).quant_(4);

Pdef(\in5Hit, Pbind(
	\instrument, \samplerStereo,
	\bufnum, a[\plate].[18].bufnum,
	\rate, Pseq([2, 1], inf),
	\hp, 1000,
	\lp, 6000,
	\rev, 1.1,
	\rel, 2,
	\dur, Pseq([15, 1], inf),
	\pan, Prand([-0.5, 0.5, 0], inf),
	\amp, Pseq([1, 0.6], inf),
	\xamp, 0,
	\out, i.inst5.index,
)).quant_([4, 0]);




e[\in5Func1] = {
	Pbindef(\in5, \xamp, 1,).reset.play;

};

e[\in5Func2] = {
	Pbindef(\in5Hit, \xamp, 1,).reset.play;
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
	\instrument, \samplerStereo,
	\bufnum, a[\VH_kick].[4].bufnum,
	\rate, Pwhite(0.8, 1.02, inf),
	\dur, Pseq([
		Pseq([Pn(1, 3),0.75, 0.25], 1), // 4
		Pseq([1, Pn(1, 3)], 1), // 4
		Pn(1, 2), // 2
		Pseq([0.25, 0.25, 0.5, 0.5, 1, 0.5, 1], 1), // 4
		0.5, 0.5, 1, // 2
	], inf),
	\amp, Pif(Pkey(\dur)<0.5, 0.5, 0.7)*2.1,
	\xamp, 0,
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

