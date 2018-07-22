// DESERT SUN
~tempo = 240/120;
//TempoClock.default.tempo = 240/120;

(
// Strings for display
~songEvents = [
	["STRINGS \n high", "STRINGS \n deep"],
	["", "", "", "SOLO"],
	["BASS 1", 		"BASS 2",		"BASS 3"],
	["GENDY"],
	["SNARE", 		"SNARE \n rel"],
	["MEL", 		"MEL \n 4/4", 	"MEL \n 8/4"],
	["KICK 4/4", 	"KICK 8/4"],
	["", "", "", "ECHO"]
];


~text;





//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 0
// SOUND 1
~stringSynth = Synth(\desert, [\out, i.inst0.index, \xamp, 0], target:~synths);

e[\in0Func1] = {
	~stringSynth.set(\xamp, 1, \f, 180);
};

e[\in0Func2] = {
	~stringSynth.set(\xamp, 1, \f, 60);
};

e[\in0Func3] = {
};


// STOP PATTERN
e[\in0Func5] ={
	~stringSynth.set(\xamp, 0);
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

};


///////////////////////////////////////
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
		Synth(\linz, [
			\out, i.inst1.index,
			\freq, freq,
			\ffreq, freq + 1000,
			\ds, rrand(1, 2),
			\amp, 0.3,
			\wn, rrand(0.03, 0.4),
			\filterFreq, 12000,
			\rel, rrand(0.5, 1),
		])
	};
});










//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 2
// BASS
//x.tone = [80, 100, 120];
Pdef(\in2,
	Pbind(\instrument, \linz,
		\dur, 0.5,
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.35,
		\wn, Pwhite(0.03, 0.09, inf),
		\freq, 80,   // 220, 240, 290 ---- 80, 100, 120
		\ffreq, Pseq([80, 100, 120], inf)*1.2,
		\bfreq, Pkey(\freq)/10,
		\ds, 1.0,
		\out, i.inst2.index,
)).quant_(4);

e[\in2Func1] = {
	Pbindef(\in2, \xamp, 1,
		\freq, 80,
		\ffreq, Pseq([80, 100, 120], inf)*1.2,
		\bfreq, Pkey(\freq),
	).reset.play;
};

e[\in2Func2] = {
	Pbindef(\in2, \xamp, 1,
		\freq, 70,
		\ffreq, Pseq([80, 100, 120], inf)*1.2,
		\bfreq, Pkey(\freq),
	).reset.play;
};

e[\in2Func3] = {
	Pbindef(\in2, \xamp, 1,
		\freq, 90,
		\ffreq, Pseq([80, 100, 120], inf)*1.2,
		\bfreq, Pkey(\freq),
	).reset.play;
};


// STOP PATTERN
e[\in2Func5] ={
	Pbindef(\in2).reset.stop;
};




//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 3
// HIGH NOISE

~gendySynth = Synth(\desertGendy, [\out, i.inst3.index, \xamp, 0, \amp, 0.4], target:~synths);

e[\in3Func1] = {~gendySynth.set(\xamp, 1); };

e[\in3Func2] = {~gendySynth.set(\xamp, 1);};

e[\in3Func3] = {~gendySynth.set(\xamp, 1);};


e[\in3Func4] = {~gendySynth.set(\xamp, 1);};





// STOP PATTERN
e[\in3Func5] ={
	~gendySynth.set(\xamp, 0);
};








//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 4
// SNARE

Pdef(\in4,
	Pbind(\instrument, \hh1,
		\dur, 2,
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.9,
		\rel, 0.5,
		\hp, 60,
		\out, i.inst4.index,
)).quant_([4, 1]);

e[\in4Func1] = {
	Pbindef(\in4, \xamp, 1, \rel, 0.2).reset.play;
};

e[\in4Func2] = {
	Pbindef(\in4, \xamp, 1, \rel, 0.4 ).reset.play;
};

e[\in4Func3] = {

};




// STOP PATTERN
e[\in4Func5] ={
	Pbindef(\in4).reset.stop;
};








//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 5
// CONTRA MELODIE WARM

Pdef(\in5,
	Pbind(\instrument, \space,
		\dur, 1,
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.7,
		\freq, Pseq([12, 22, 66, 99], inf),
		\fb, 0.3,
		\out, i.inst5.index,
));

e[\in5Func1] = {
	Pbindef(\in5, \xamp, 1,
		\dur, 1,
		\fb, 0.3,
	).reset.play;
};

e[\in5Func2] = {
	Pbindef(\in5, \xamp, 1,
		\dur, 0.5,
		\fb, 1.3,
	).reset.play;
};

e[\in5Func3] = {
	Pbindef(\in5, \xamp, 1,
		\dur, 0.25,
		\fb, 1.3,
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
	Pbind(\instrument, \kickDesert,
		\dur, 1,
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.6,
		\bd, Pwhite(0.7, 0.8, inf),
		\out, i.inst6.index,
)).quant_(4);


e[\in6Func1] ={
	Pbindef(\in6, \xamp, 1, \dur, 1).reset.play;
};


e[\in6Func2] ={
	Pbindef(\in6, \xamp, 1, \dur, 0.5,).reset.play;
};

e[\in6Func3] ={

};





// STOP PATTERN
e[\in6Func5] ={
	Pbindef(\in6).reset.stop;
};









) // EOF