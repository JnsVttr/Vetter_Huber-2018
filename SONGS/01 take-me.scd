
(

// TAKE ME
~tempo = 240/120;


// Strings for display
~songEvents = [
	["RHYT 1", "RHYT 1"],
	["PERC \n shift"],
	["BASS", 		"BASS \n 5/4",		"BASS \n high"],
	[],
	[],
	["HH", 		"HHH_8",  "HH_FULL"],
	["KICK 4/4", "KICK 2/4", "KICK 4/8"],
	["", "", "", "ECHO"]
];


~text;







//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 0
// BASS MELODIE DIRTY
x = ();
x.dur = Plazy({
	Pseq([
		Pn(1, 2),
		Pn(0.5, 8),
		Pn(0.25, 12),
		Pn(0.125, 4)
	], inf)
});
x.note = Plazy ({
	Pseq([
		Pn(1, 8),
		Pn(2, 8),
		Pn(3, 8),
		Prand([5, 8], 4)
	], inf)-12
});
x.pan = Plazy({
	Pwhite(-1, 1, inf)
});

Pdef(\in0,
	Pbind(\instrument, \Bass,
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.7,
		\dur, x.dur,
		//	\note, x.note,
		//	\note, 1,
		\freq, 110,
		\pan, Pwhite(-0.3, 0.3, inf),
		\rel, Pkey(\dur)/3,
		\hp, Pkey(\dur)*2000+6000,
		\fb, Pwhite(1, 3, inf),
		\out, i.inst0.index,
)).quant_(4);


e[\in0Func1] = {
	Pbindef(\in0, \xamp, 1,
		\freq, 80,
	).reset.play;
};


e[\in0Func2] = {
	Pbindef(\in0, \xamp, 1,
		\freq, 110,
	).reset.play;
};

e[\in0Func3] = {
	Pbindef(\in0, \xamp, 1,
		\note, x.note,
	).reset.play;
};




// STOP PATTERN
e[\in0Func5] ={
	Pbindef(\in0).reset.stop;
};





//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 1
// NOISE WELLEN

Pdef(\in1,
	Pbind(\instrument, \noise,
		\dur, 0.5,
		\xamp, 0,
		\amp, Pkey(\xamp) * Pseq([0.2, 0.6, 0.1], inf)*0.8,
		\level, 2,
		\lp, 4000,
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
// STRING MELODIE
Pdef(\in2,
	Pbind(\instrument, \done,
		\xamp, 0,
		\amp, Pkey(\xamp) * 1.2,
		\dur, Pseq([
			Pn(0.125, 4),
			Pn(1, 4),
			Pn(0.25, 4),
		], inf),
		\freq, Pseq([
			Pn(110, 12),
			Pn(80, 4),
			Pn(135, 8),
		], inf)*1,
		\vib, Pwhite(0.2, 1.4, inf),
		\atk, 0.01,
		\out, i.inst2.index,
)).quant_(4);


e[\in2Func1] = {
	Pbindef(\in2, \xamp, 1,
		\freq, [110],
		\dur, Pseq([Pn(1, 4)], inf)
	).reset.play;
};

e[\in2Func2] = {
	Pbindef(\in2, \xamp, 1,
		\vib, 1.2,
		\dur, Pseq([Pn(1, 7),Pn(0.125, 4)], inf),
		\freq, 110,
	).reset.play;
};

e[\in2Func3] = {
	Pbindef(\in2, \xamp, 1,
		\dur, Pseq([
			Pn(0.125, 4),
			Pn(1, 4),
			Pn(0.25, 4),
		], inf),
		\freq, Pseq([
			Pn(110, 12),
			Pn(80, 4),
			Pn(135, 8),
		], inf)*1,
		\vib, 1.2,
	).reset.play;
};




// STOP PATTERN
e[\in2Func5] ={
	Pbindef(\in2).reset.stop;
};




///////////////////////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 3
// SOLO 3

e[\in3Func1] = {
};

e[\in3Func2] = {
};

e[\in3Func3] = {
};




// STOP PATTERN
e[\in3Func5] ={
	//Pbindef(\in3).reset.stop;
};




//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 4
//

e[\in4Func1] = {
};

e[\in4Func2] = {
};

e[\in4Func3] = {
};


// STOP PATTERN
e[\in4Func5] ={
	//Pbindef(\in4).reset.stop;
};



//////////////////////////////////////////////////////////////////////////////////////////
// CHANNEL 5
// HH
Pdef(\in5,
	Pbind(\instrument, \hh1,
		\dur, 0.5,
		\rel, 0.1,
		\xamp, 0,
		\amp, Pkey(\xamp) * 0.5,
		\out, i.inst5.index,
)).quant_([4, 0]).reset;

e[\in5Func1] = {
	Pbindef(\in5, \xamp, 1,
		\dur, 0.5,
		\rel, 0.1,
		\amp, Pkey(\xamp) * 0.5,
	).reset.play;
};

e[\in5Func2] = {
	Pbindef(\in5, \xamp, 1,
		\dur, 0.25,
		\rel, Pwhite(0.1, 0.3, inf),
		\amp, Pkey(\xamp) * Pseq([0.5, 1, 0.5, 1], inf)*0.6,
	).reset.play;
};

e[\in5Func3] = {
	Pbindef(\in5, \xamp, 1,
		\dur, 0.25,
		\rel, 1,
		\amp, Pkey(\xamp) * 0.5,
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
		\amp, Pkey(\xamp) * Pseq([0.9, 0.9, 0.9, 0.4], inf)*0.9,
		\bd, Pseq([
			Pn(0.9, 7),
			Pn(1.2, 1),
		], inf),
		\out, i.inst6.index,
)).quant_(4);


e[\in6Func1] ={
	Pbindef(\in6, \xamp, 1,
		\dur, 1,
		\bd, Pseq([
			Pn(0.9, 7),
			Pn(1.2, 1),
		], inf),
	).reset.play;
};

e[\in6Func2] ={
	Pbindef(\in6, \xamp, 1,
		\dur, 2,
		\bd, Pseq([
			Pn(0.9, 7),
			Pn(0.8, 1),
		], inf),
	).reset.play;
};

e[\in6Func3] ={
	Pbindef(\in6, \xamp, 1,
		\dur, 0.5,
		\bd, Pseq([
			Pn(0.4, 3),
			Pn(0.8, 1),
			Pn(1.1, 1),
		], inf),
	).reset.play;
};



// STOP PATTERN
e[\in6Func5] ={
	Pbindef(\in6).reset.stop;
};












) // EOF










/*

// Bass Melodie Version 0
(
~in3Func1 = {
p[\in3].quant_(4);
p[\in3] = Pdef(\string,
		Pbind(\instrument, \done,
			\dur, Pseq([
				Pn(0.125, 4),
				Pn(1, 4),
				Pn(0.25, 4),
			], inf),
			\freq, Pseq([
				Pn(110, 12),
				Pn(80, 4),
				Pn(135, 8),
			], inf)*1,
			\amp, 1.9,
			\vib, Pwhite(0.2, 1.4, inf),
			\atk, 0.01,
	));

//Pbindef(\string, \freq, [70, 140, 210]);
Pbindef(\string, \freq, [110]);
Pbindef(\string, \dur, Pseq([Pn(1, 4)], inf));
};

)

// Bass Melodie Version 1

(
~in3Func2 = {
p[\in3].quant_(4);
p[\in3] = Pdef(\string, Pbind(
	\instrument, \done,
	\dur, Pseq([
		Pn(0.125, 4),
		Pn(1, 4),
		Pn(0.25, 4),
	], inf),
	\freq, Pseq([
		Pn(110, 12),
		Pn(80, 4),
		Pn(135, 8),
	], inf)*1,
	\amp, 2.3,
	\vib, 1.2,
));

	// Pbindef(\string, \freq, Pseq([
	// 	Pn(110, 5),
	// 	Pn(90, 5),
	// 	Pn(120, 3),
	// ], inf)); // 110, 80, 120,            .. 55, 60, 70

//Pbindef(\string, \dur, Pseq([Pn(1, 5),Pn(0.25, 4), Pn(1, 2), Pn(0.125, 4)], inf));
Pbindef(\string, \dur, Pseq([Pn(1, 7),Pn(0.125, 4)], inf), \freq, 110);
}
)

// Bass Melodie Version 3
(
~in3Func3 = {
p[\in3].quant_(4);
p[\in3] = Pdef(\string, Pbind(
	\instrument, \done,
	\dur, Pseq([
		Pn(0.125, 4),
		Pn(1, 4),
		Pn(0.25, 4),
	], inf),
	\freq, Pseq([
		Pn(110, 12),
		Pn(80, 4),
		Pn(135, 8),
	], inf)*1,
	\amp, 1.9,
	\vib, 1.2,
));
}
)

*/


