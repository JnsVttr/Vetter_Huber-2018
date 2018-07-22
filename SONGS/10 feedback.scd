


(
// FEEDBACK
~tempo = 118/60;


// Strings for display
~songEvents = [
	["HITS 32"],
	["BOOM", nil, nil, "SOLO"],
	["STRING"],
	["TOM"],
	["SNARE"],
	["HH"],
	["KICK \n LOW", "KICK \n BEAST"],
	["", "", "", "ECHO"]
];


~text;





//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 0
// HITS
Pdef(\in0, Pbind(
	\instrument, \schwing,
	\rel, 1,
	\pan, Pwhite(-0.3, 0.3, inf),
	\lp, 4000,
	\dur, 16,
	\amp, 1.7,
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
// Lock
Pdef(\in1, Pbind(
	\instrument, \locking,
	\dur, 8,
	\freqMul, 1.2,
	\atk, 0.01,
	\rel, 2,
	\amp, 1.9,
	\xamp, 0,
	\out, i.inst1.index,
)).quant_(4);

e[\in1Func1] = {
	Pbindef(\in1, \xamp, 1).reset.play;
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
// STRINGS
Pdef(\in2, Pbind(
	\instrument, \samplerStereo,
	\bufnum, [a[\string].[0].bufnum],
	\pan, Pwhite(-0.3, 0.3, inf),
	\lp, 13000,
	\rev, 0.9,
	\dur, Pseq([
		4
		//Pseq([1, 0.5, 1, 0.5, 0.5, 2], 2)
	], inf), //Pseq([Pn(0.25, 4), Prand([6, 2, 14], 1)], inf),
	\rel, Pif(Pkey(\dur)<3, 0.3, Prand([0.7, 1, 2.4], inf))*3,
	//\rate, Pif(Pkey(\dur)<3, 0.63, 0.6)*1.6,
	\rate, 0.96,
	\amp, 2.3,
	\xamp, 0,
	\out, i.inst2.index,
)).quant_(4);


e[\in2Func1] = {
	Pbindef(\in2, \xamp, 1, \rate, 0.96).reset.play;
};

e[\in2Func2] = {

};

e[\in2Func3] = {

};


// STOP PATTERN
e[\in2Func5] ={
	Pbindef(\in2).reset.stop;
};




//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 3
// TOM
Pdef(\in3, Pbind(
	\instrument, \samplerMonoPerc,
	\bufnum, [a[\drum_TOM].[3].bufnum],
	\rel, 0.05,
	\rate, Pseq([1.4, 2, 3.4, 4, 2.6], inf),
	\pan, Pwhite(-0.3, 0.3, inf),
	\lp, 13000,
	\dur, Pseq([Pn(0.25, 4), Prand([6, 14, 3])], inf),
	//\dur, Pseq([Pn(0.25, 4), 15], inf),
	\rev, 1.8,
	\amp, 2.8,
	\xamp, 0,
	\out, i.inst3.index,
)).quant_(4);


e[\in3Func1] = {
	Pbindef(\in3, \xamp, 1).quant_(4).reset.play;
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
Pdef(\in4, Pbind(
	\instrument, \samplerMonoPerc,
	\bufnum, [a[\drum_SN].[3].bufnum, a[\drum_HAT].[4].bufnum],
	\rel, 0.3,
	\rate, 1.3, //Pseq([1.4, 2, 3.4, 4, 2.6], inf),
	\pan, Pwhite(-0.3, 0.3, inf),
	\lp, 4000,
	\dur, 2, //Pseq([Pn(0.25, 4), Prand([6, 2, 14], 1)], inf),
	\amp, 1,
	\rev, Prand([0.5, 0.3, 0.2], inf),
	\xamp, 0,
	\out, i.inst4.index,
)).quant_([4, -3]).reset;


e[\in4Func1] = {
	Pbindef(\in4, \xamp, 1, \dur, 2, \amp, 1.5, \rel, 0.3, \lp, 5000).quant_([4, -3]).reset.play;
	/*
	Pbindef(\in4, \xamp, 1, \dur, 0.25, \amp, 1, \rel, 0.15, \lp, 9000).quant_([4, -3]).reset.play;
	*/
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
	\instrument, \samplerMonoPerc,
	\bufnum, [a[\drum_HAT].[0].bufnum],  // BD change 12, 15, 10
	\rel, 0.8,
	\rate, Pwhite(0.7, 1.4, inf),
	\pan, Pwhite(-0.3, 0.3, inf),
	\lp, 13000,
	\dur, 0.25,
	\amp, 1.1,
	\xamp, 0,
	\out, i.inst5.index,
)).quant_(4);


e[\in5Func1] = {
	Pbindef(\in5, \xamp, 1,).reset.play;

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
	\instrument, \samplerMonoPerc,
	\bufnum, [a[\drum_BD].[11].bufnum],  // BD change 12, 15, 10
	\rel, 0.3,
	\rate, Pwhite(0.7, 1.4, inf),
	\pan, Pwhite(-1.0, 1, inf),
	\lp, 19000,
	\dur, 0.25,
	\amp, 1.9,
	\xamp, 0,
	\out, i.inst6.index,
)).quant_(4);



Pdef(\in6one, Pbind(
	\instrument, \samplerMonoPerc,
	\bufnum, [a[\drum_TOM].[2].bufnum],
	\rel, 0.5,
	\rate, Pwhite(1.5, 2.2, inf)*3,
	\pan, Pwhite(-0.7, 0.7, inf),
	\lp, 19000,
	\dur, Pseq([Pn(0.25, 16), 8], inf),
	//\dur, Pseq([Pn(0.25, 4), 15], inf),
	\rev, 0.9,
	\amp, 1.3,
	\xamp, 0,
	\out, i.inst6.index,
)).quant_(4);







e[\in6Func1] ={
	Pbindef(\in6, \xamp, 1, \amp, 1, \bufnum, [a[\drum_BD].[11].bufnum], \rel, 0.2, \pan, 0).reset.play;
	Pbindef(\in4, \xamp, 1, \dur, 2, \amp, 1.5, \rel, 0.3, \lp, 5000).quant_([4, -3]).reset.play;
	Pdef(\in6one).stop;
};

e[\in6Func2] ={
	Pbindef(\in6, \xamp, 1, \amp, 2.3, \bufnum, [a[\drum_BD].[13].bufnum], \rel, 0.4, \pan, Pwhite(-1.0, 1, inf)).reset.play;
	// SNARE
	Pbindef(\in4, \xamp, 1, \dur, Pseq([Pn(0.25, 8), Prand([Pn(0.25, 8), Pn(0.125, 12), Pn(0.25, 16)], 2)], inf), \amp, 2.3, \rel, 0.15, \lp, 9000).quant_(4).reset.play;
	Pdef(\in6one).quant_(4).play;
};

e[\in6Func3] ={
};

// STOP PATTERN
e[\in6Func5] ={
	Pbindef(\in6).reset.stop;
	Pbindef(\in6one).reset.stop;
	Pbindef(\in4).reset.stop;
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
			\freq, freq*2,
			\atk, 0.2,
			\rel, 0.2,
			\amp, 0.13,
			\out, i.inst1.index,
		])
	};
});


) // END OF FILE

