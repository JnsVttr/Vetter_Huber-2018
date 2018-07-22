
(
// FOLLOW ME
~tempo = 134/60;


// Strings for display
~songEvents = [
	["RHYT", "LOOP", "QUEER"],
	["", "", "", "SOLO"],
	["BASS"],
	["MEL", "PIPE", "SIGN"],
	["SNARE"],
	["HH"],
	["KICK"],
	["", "", "", "ECHO"]
];


~text;


//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 0
// RHYT
Pdef(\in0, Pbind(
	\instrument, \samplerStereo,
	\bufnum, Prand([
		a[\tools].[0].bufnum,
		a[\tools].[1].bufnum,
		a[\tools].[2].bufnum,
	], inf),
	\rate, 0.4,
	\lp, 9220,
	\dur, Pseq([Pn(0.25, 16), 1, Pn(0.5, 8), 1, Pn(0.125, 4)], inf)*1,
	\rel, 0.15,
	\amp, 6.6,
	\xamp, 0,
	\out, i.inst0.index,
)).quant_(4);

Pdef(\in0Loop, Pbind(
	\instrument, \samplerStereo,
	\bufnum, a[\electro_sounds].[1],
	\loop, 0, \done, 2,
	//\startPos, Pseq([20222, 5200000, 10111222, 7200000], inf),
	\startPos, Pseq([3000000, 9000000, 132222, 5000000].scramble, inf),
	\rel, 0.25,
	\rate, 2.9,
	\lp, Pseq([Pn(630, 5), Pn(2230, 2)], inf)*3,
	//\dur, Pseq([Pn(2, 4), Pn(1, 16), Pn(3, 2)], inf),
	\dur, Pn(0.5, 16),
	\amp, 2.6,
	\xamp, 0,
	\out, i.inst0.index,
)).quant_(4);

Pdef(\in0Base, Pbind(
	\instrument, \samplerStereo,
	\bufnum, a[\electro_sounds].[1],
	\loop, 0, \done, 2,
	\startPos, Pseq([20222, 5200000, 10111222, 7200000], inf),
	//\startPos, Pseq([8120222, 1200, 12111222, 2111222], inf),
	\rel, 0.8,
	\rate, -1,
	\lp, 5620,
	//\dur, Pseq([Pn(2, 4), Pn(1, 16), Pn(3, 2)], inf),
	\dur, Pseq([Pn(1, 8)], 2),
	\amp, 1.8,
	\xamp, 0,
	\out, i.inst0.index,
)).quant_(4);



e[\in0Func1] = {
	Pbindef(\in0, \xamp, 1).reset.play;
};

e[\in0Func2] = {
	Pbindef(\in0Loop, \xamp, 1).reset.play;
};

e[\in0Func3] = {
	Pbindef(\in0Base, \xamp, 1).reset.play;
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
// BASS
Pdef(\in2, Pbind(
	\instrument, \bass,
	/*\freq, Pseq([
		40, 120, 90, 80, 60, 50, 230,
		Pn(70, 4),
		Pn(240, 2)
	], inf)*1.2,    // reverse, scramble, mirror*/
	\freq, Pseq([
		Pseq([Pn(60, 4), 120, 130, Pn(40, 2)], 4)*1,
		Pseq([Pn(60, 4), 120, 130, Pn(40, 2)], 2)*1.3,
		Pseq([Pn(65, 4), 220, 230, Pn(120, 2)], 1)*1,
		Pseq([Pn(65, 4), 220, 230, Pn(320, 2)], 1)*1,
		/*Pseq([Pn(60, 4), 120, 130, Pn(40, 2)], 2)*1.3,
		Pseq([Pn(60, 4), 120, 130, Pn(40, 2)], 1)*1.6,
		Pseq([Pn(60, 4), 120, 130, Pn(60, 2)], 1)*1.8,*/
	], inf),
	\dur, Pseq([Pn(0.5, 4), Pn(0.5, 8), Pn(0.5, 6)], inf),
	//\dur, Pseq([Pn(1, 16), Pn(1, 4)], inf),
	\rel, 0.2,
	\lp, Pseq([Pn(400, 12), Pn(300, 5), Pn(600, 4)], inf)*2.8,
	\fb, 3,
	\mix, 0,
	\amp, 1.2,
	\xamp, 0,
	\out, i.inst2.index,
)).quant_([4, 0.5]);


e[\in2Func1] = {
	Pbindef(\in2, \xamp, 1).reset.play;
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
// MEL
Pdef(\in3, Pbind(
	\instrument, \bass,
	\freq, Pseq([120, 126, 118], inf)*3,
	\rel, Pwhite(1, 1.8, inf),
	\dur, Pseq([1, 0.5, 2.5], 4),
	\lp, 7320,
	\fb, 2,
	\mix, 0.8,
	\amp, 0.6,
	\xamp, 0,
	\out, i.inst3.index,
)).quant_(4);

Pdef(\in3Pipe, Pbind(
	\instrument, \schon,
	\freq, Pseq([1000, 1800, 1200, 1400], inf),
	\rel, 2,
	\move, 0.1,
	\moveFreq, 41.2,
	\bp, 5000,
	\dur, Pn(2, 8),
	\amp, 6,
	\xamp, 0,
	\out, i.inst3.index,
)).quant_(4);

Pdef(\in3Sign, Pbind(
	\instrument, \samplerStereo,
	\bufnum, Pseq([a[\electro_sounds].[0], a[\electro_sounds].[1], a[\electro_sounds].[1]], 2),  // 0
	\loop, 0, \done, 2,
	\startPos, Pseq([3332300, 4523000, 2200000, 2720000], inf),
	\rel, 0.8,
	\rate, 1.7,
	\lp, 9620,
	\dur, Pseq([Pn(1, 4)], 2),
	\amp, 2.1,
	\xamp, 0,
	\out, i.inst3.index,
)).quant_(4);




e[\in3Func1] = {
	Pbindef(\in3, \xamp, 1).reset.play;
};

e[\in3Func2] = {
	Pbindef(\in3Pipe, \xamp, 1).reset.play;
};

e[\in3Func3] = {
	Pbindef(\in3Sign, \xamp, 1).reset.play;
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
	\bufnum, a[\drum_SN].[3],
	\loop, 0, \done, 2,
	\rel, 1,
	\rate, 1,
	\lp, 9620,
	\dur, Pseq([Pn(2, 8), Pn(2, 8)], inf),
	\amp, 0.9,
	\xamp, 0,
	\out, i.inst4.index,
)).quant_([4, -3]).reset;

e[\in4Func1] = {
	Pbindef(\in4, \xamp, 1).quant_([4, -3]).reset.play;
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
	\bufnum, a[\drum_HAT].[1].bufnum,
	\rel, 0.6,
	\rate, 1,
	\lp, 3620,
	//\dur, Pseq([Pn(2, 8), Pn(0.5, 8), Pn(2, 8), Pn(0.25, 8)], inf)*0.25,
	\dur, 0.5,
	\amp, 1.8,
	\xamp, 0,
	\out, i.inst5.index,
)).quant_(4).reset;



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
	\instrument, \samplerMonoPerc,
	\bufnum, Pseq([
		//Pn(a[\drum_BD].[9].bufnum, 4),
		//a[\drum_BD].[18].bufnum,
		a[\drum_BD].[14].bufnum,    // 13, 2, 15
	], inf),
	//\rate, Prand([0.3, 0.4, 0.5], inf),
	\rate, 1,
	\lp, 12620,
	//\dur, Pseq ([Pn(2, 8), Pn(1, 4), Pn(2, 8), Pn(2, 8)], inf),
	//\dur, Pseq([Pn(2, 8), 1, Pn(2, 8), 1], inf),
	\dur, 1,
	\amp, 2,
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

