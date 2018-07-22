
// NEW SYSTEM TESTS


// Dynamic Songs Processing

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
// Load all songs in Array (fileNames + names)
(
~dynSongName = Array.fill(30);
~dynSongFileName = Array.fill(30);
~dynSongs = {
	"-----------------------------------------------------".postln;
	"SYNTH Entries: ".postln;
	PathName(thisProcess.nowExecutingPath.dirname +/+ "SONGS").entries.collect({|c, i|
		var name, fileName, counter;
		counter = i;
		fileName = c.fileName;
		~dynSongFileName.put(i, fileName);
		name = c.fileNameWithoutExtension;
		name = name.split($ )[1].replace("-", " ");
		//c.fullPath.load;
		~dynSongName.put(i, name)
	});
	"".postln;
};
~dynSongs.value;
~dynSongName.postln;
~dynSongFileName.postln;
)

/*
~string = "12 desert";
~string.at(2);
~string.split($ )[1]
~string.beginsWith(12.asString)
~string.replace((12.asString ++ " "), "")
*/












//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
// Load Presets for files

(
~dynSongEncoder = Array.fill(30);
~dynSongSlider = Array.fill(30);
~encoderFileName = thisProcess.nowExecutingPath.dirname ++ "/encoderpositions.txt";
~sliderFileName = thisProcess.nowExecutingPath.dirname ++ "/sliderpositions.txt";

// ENCODER
// open file, read and put strings into array, close file.
~encFile = FileReader.read(~encoderFileName, delimiter:$,);
"".postln;
("ENCODER values available for: ").postln;
"".postln;
~encoderFile.postln;
"- - - - - - - ".postln;
// check for all songs in Song-Dir
~dynSongName.do({|c, k|
	// if a song is there, continue
	if (c!=nil, {
		var name, encMatch;
		name = c;
		// bool for storing match between song-dir and enc-file
		encMatch = false;
		// check encFile for apropriate content
		~encFile.do({|i|
			// if values are available ..
			if (i[0].asString == name.asString, {
				var valArray;
				valArray = Array.fill(8);
				encMatch = true;
				// .. store them in local array
				8.do({|c|
					valArray.put(c, i.[c+1])
				});
				// assign songName + values to storage
				~dynSongEncoder.put(k, [name.asString, valArray]);
			});
		});

		// control if there are values for all
		if (encMatch == true, {
			name.postln;
		},
		{   // store with new values at 1
			var valArray = Array.fill(8, 1);
			name.post;
			(" -----> NO VALUES. Set temporary new!").postln;
			~dynSongEncoder.put(k, [name.asString, valArray]);
		});
	});
});
"".postln;
~dynSongEncoder.do({|c| if (c!=nil, {c.postln})});
"".postln;

// SLIDER
// open file, read and put strings into array, close file.
~sliderFile = FileReader.read(~sliderFileName, delimiter:$,);
"".postln;
("SLIDER values available for: ").postln;
"".postln;
~sliderFileName.postln;
"- - - - - - - ".postln;
// check for all songs in Song-Dir
~dynSongName.do({|c, k|
	// if a song is there, continue
	if (c!=nil, {
		var name, encMatch;
		name = c;
		// bool for storing match between song-dir and enc-file
		encMatch = false;
		// check encFile for apropriate content
		~sliderFile.do({|i|
			// if values are available ..
			if (i[0].asString == name.asString, {
				var valArray;
				valArray = Array.fill(8);
				encMatch = true;
				// .. store them in local array
				8.do({|c|
					valArray.put(c, i.[c+1])
				});
				// assign songName + values to storage
				~dynSongSlider.put(k, [name.asString, valArray]);
			});
		});

		// control if there are values for all
		if (encMatch == true, {
			name.postln;
		},
		{   // store with new values at 1
			var valArray = Array.fill(8, 1);
			name.post;
			(" -----> NO VALUES. Set temporary new!").postln;
			~dynSongSlider.put(k, [name.asString, valArray]);
		});
	});
});
"".postln;
~dynSongSlider.do({|c| if (c!=nil, {c.postln})});
"".postln;
)








//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
// Important Arrays (files, values, etc.)

// set up variables
i = ();  // init-variables
a = ();  // sample dictionary
a = Dictionary.new;
b = ();  // control Busses for NanoKontrol2
e = ();  // functions
k;       // variable for NanoKontrol2/ icon
x = ();  // Array for Plazys + SongParts

// define directories Samples/ Synths
i.sampleDir = thisProcess.nowExecutingPath.dirname +/+ "AUDIO/";
i.synthDir = thisProcess.nowExecutingPath.dirname +/+ "SYNTH_DEF/";
i.mastersynth = thisProcess.nowExecutingPath.dirname +/+ "SYNTH_DEF/synthdefs.scd";
i.mastersynth.load;

// locate external doc's
i.iconFile = thisProcess.nowExecutingPath.dirname +/+ "SYSTEM/init-icon.scd";
i.iconFile.load;

i.stopPatternFile = thisProcess.nowExecutingPath.dirname +/+ "SYSTEM/stop-pattern.scd";
//i.stopPatternFile.load;

// START - FILE
i.bootFile = thisProcess.nowExecutingPath.dirname +/+ "SYSTEM/boot-system.scd";
i.bootFile.load;

// Songs (Playlist Dresden) for GUI
i.song1 = "1 TAKE ME"; i.song1URL = thisProcess.nowExecutingPath.dirname +/+ "SONGS/take-me.scd";
i.song2 = "2 DESERT SUN"; i.song2URL = thisProcess.nowExecutingPath.dirname +/+ "SONGS/desert-sun.scd";
i.song3 = "3 FOLLOW ME"; i.song3URL = thisProcess.nowExecutingPath.dirname +/+ "SONGS/follow-me.scd";
i.song4 = "4 HAMBURG"; i.song4URL = thisProcess.nowExecutingPath.dirname +/+ "SONGS/hamburg.scd";
i.song5 = "5 AMPHETAMIN"; i.song5URL = thisProcess.nowExecutingPath.dirname +/+ "SONGS/amphetamin.scd";
i.song6 = "6 KARMA"; i.song6URL = thisProcess.nowExecutingPath.dirname +/+ "SONGS/karma.scd";
i.song7 = "7 POISON"; i.song7URL = thisProcess.nowExecutingPath.dirname +/+ "SONGS/poison.scd";
i.song8 = "8 PASSION"; i.song8URL = thisProcess.nowExecutingPath.dirname +/+ "SONGS/passion.scd";
i.song9 = "9 FEEL THE NEED"; i.song9URL = thisProcess.nowExecutingPath.dirname +/+ "SONGS/feel-the-need.scd";
i.song10 = "10 DANCE SLOWLY"; i.song10URL = thisProcess.nowExecutingPath.dirname +/+ "SONGS/dance-slowly.scd";
i.song11 = "11 FEEDBACK"; i.song11URL = thisProcess.nowExecutingPath.dirname +/+ "SONGS/feedback.scd";
i.songCurr = "empty";

// WINDOW
i.windowFile = thisProcess.nowExecutingPath.dirname +/+ "SYSTEM/make-window.scd";
i.windowFile.load;

i.iconVal = ();
i.iconVal.putPairs([
	\rec, [0,1,2,	3,	4,	5,	6,	7],
	\solo, [8,	9,	10,	11,	12,	13,	14,	15],
	\mute, [16,	17,	18,	19,	20,	21,	22,	23],
	\select, [24,	25,	26,	27,	28,	29,	30,	31],
	\push, [32,	33,	34,	35,	36,	37,	38,	39],
	\knob, [16,	17,	18,	19,	20,	21,	22,	23],
]);

i.iconState = ();
i.iconState.putPairs([
	\rec, Array.fill(8, false),
	\solo, Array.fill(8, false),
	\mute, Array.fill(8, false),
	\select, Array.fill(8, false),
]);

i.iconEncSpeed = ();
i.iconEncSpeed.putPairs([
	\left, [0.512, 0.551, 0.598, 0.606],
	\right, [0.008, 0.031, 0.063, 0.078],
]);

~dynSongEnc =
[ take me, [ 1, 1, 1, 1, 1, 1, 1, 1 ] ]
[ desert sun, [ 0, 0.3, 0.9, 0, 1, 0, 1, 0.7 ] ]
[ follow me, [ 1, 1, 1, 1, 1, 1, 1, 1 ] ]
[ hamburg, [ 1, 1, 1, 1, 1, 1, 1, 1 ] ]
[ amphetamin, [ 1, 1, 1, 1, 1, 1, 1, 1 ] ]
[ karma, [ 1, 1, 1, 1, 1, 1, 1, 1 ] ]
[ poison, [ 1, 1, 1, 1, 1, 1, 1, 1 ] ]
[ passion, [ 1, 1, 1, 1, 1, 1, 1, 1 ] ]
[ feel the need, [ 1, 1, 1, 1, 1, 1, 1, 1 ] ]
[ dance slowly, [ 1, 1, 1, 1, 1, 1, 1, 1 ] ]
[ feedback, [ 1, 1, 1, 1, 1, 1, 1, 1 ] ]


~dynSongContent = [
	[ take me, [
		[ "RHYT 1", "RHYT 1", nil, nil ],
		[ "PERC shift", nil, nil, nil],
		[ "BASS", "BASS 5/4", "BASS high-mel", nil],
		[ nil, nil, nil, nil ],
		[ nil, nil, nil, nil ],
		[ "HH 4/4", "HH 4/8", "HH -FULLcc", nil ],
		[ "KICK 4/4", "KICK 2/4", "KICK 4/8", nil],
	] ],
	[ desert sun, [
		[ nil, nil, nil, nil ],
		[ nil, nil, nil, nil ],
		[ nil, nil, nil, nil ],
		[ nil, nil, nil, nil ],
		[ nil, nil, nil, nil ],
		[ nil, nil, nil, nil ],
		[ nil, nil, nil, nil ],
	] ],
];









//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
//  Icon Platform m+   Arrays for everthing

// Buttons
(
// Buttons MIDIOut
i.iconVal = ();
i.iconVal.putPairs([
	\rec, [0,1,2,	3,	4,	5,	6,	7],
	\solo, [8,	9,	10,	11,	12,	13,	14,	15],
	\mute, [16,	17,	18,	19,	20,	21,	22,	23],
	\select, [24,	25,	26,	27,	28,	29,	30,	31],
	\push, [32,	33,	34,	35,	36,	37,	38,	39],
	\knob, [16,	17,	18,	19,	20,	21,	22,	23],
]);



//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
// Buttons State Array
i.iconState = ();
i.iconState.putPairs([
	\rec, Array.fill(8, false),
	\solo, Array.fill(8, false),
	\mute, Array.fill(8, false),
	\select, Array.fill(8, false),
]);
// Button Function Array
i.iconButtonFuncOn = ();
i.iconButtonFuncOn.putPairs([
	\rec, Array.fill(8, nil),
	\solo, Array.fill(8, nil),
	\mute, Array.fill(8, nil),
	\select, Array.fill(8, nil),
]);
8.do({|c|
	i.iconButtonFuncOn[\rec][c] = {"rec pressed".postln};
	i.iconButtonFuncOn[\solo][c] = {"solo pressed".postln};
	i.iconButtonFuncOn[\mute][c] = {"mute pressed".postln};
	i.iconButtonFuncOn[\select][c] = {"select pressed".postln};
});

i.iconButtonFuncOff = ();
i.iconButtonFuncOff.putPairs([
	\rec, Array.fill(8, nil),
	\solo, Array.fill(8, nil),
	\mute, Array.fill(8, nil),
	\select, Array.fill(8, nil),
]);
8.do({|c|
	i.iconButtonFuncOff[\rec][c] = {"rec unpressed".postln};
	i.iconButtonFuncOff[\solo][c] = {"solo unpressed".postln};
	i.iconButtonFuncOff[\mute][c] = {"mute unpressed".postln};
	i.iconButtonFuncOff[\select][c] = {"select unpressed".postln};
});

// assign \mute, \solo, \select, \rec Buttons
[\mute, \solo, \select, \rec].do({|c|
	var buttonName = c.asSymbol;
	8.do({|c|
		~kontrol.elementAt(\bt, buttonName, c).action_({ |el|
			if ((el.value==1) && (i.iconState[buttonName][c]==false), {
				~kontrolMidi.noteOn(0, i.iconVal[buttonName][c], 1);
				i.iconState[buttonName][c] = true;
				i.iconButtonFuncOn[buttonName][c].value;
				// change model
				switch(buttonName,
					\select, {i.iconMVCArray[\modelButtons][c] = true; i.iconMVCArray[\modelButtons].changed(\val)},
					\mute, {i.iconMVCArray[\modelButtons][c+8] = true; i.iconMVCArray[\modelButtons].changed(\val)},
					\solo, {i.iconMVCArray[\modelButtons][c+16] = true; i.iconMVCArray[\modelButtons].changed(\val)},
					\rec, {i.iconMVCArray[\modelButtons][c+24] = true; i.iconMVCArray[\modelButtons].changed(\val)},
				);
			},
			{
				if ((el.value==1) && (i.iconState[buttonName][c]==true), {
					~kontrolMidi.noteOn(0, i.iconVal[buttonName][c], 0);
					i.iconState[buttonName][c] = false;
					i.iconButtonFuncOff[buttonName][c].value;
					// change model
				switch(buttonName,
					\select, {i.iconMVCArray[\modelButtons][c] = false; i.iconMVCArray[\modelButtons].changed(\val)},
					\mute, {i.iconMVCArray[\modelButtons][c+8] = false; i.iconMVCArray[\modelButtons].changed(\val)},
					\solo, {i.iconMVCArray[\modelButtons][c+16] = false; i.iconMVCArray[\modelButtons].changed(\val)},
					\rec, {i.iconMVCArray[\modelButtons][c+24] = false; i.iconMVCArray[\modelButtons].changed(\val)},
				);
				});
			});
		});
	});
});


// all Buttons off
i.allButtonsOff = {
	[\mute, \solo, \select, \rec].do({|c|
		var buttonName = c.asSymbol;
		8.do({|c|
			~kontrolMidi.noteOn(0, i.iconVal[buttonName][c], 0);
		});
	});
};
i.allButtonsOff.value;
)




//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
// TRANSPORT
(

// Global Icon value array
i.iconValueArray = ();
i.iconValueArray.putPairs([
	\slider, Array.fill(9, 1),
	\encoder, Array.fill(8, 1),
	\ctrl, 1,
]);
/*
a = MKtl(\midi_1_platfo).desc;
a.postElements;     // post element names and keys/indices in hierarchical order
*/


// Transport Functions:

i.iconTransportFunc = ();
i.iconTransportFunc.putPairs([
	\ctrl_tch_on, {},
	\ctrl_tch_off, {},
	\ctrl, {},
	\play, {},
	\stop, {},
	\rec, {},
	\cycle, {},
	\rew, {},
	\fwd, {},
	\chan_prev, {},
	\chan_next, {},
	\bank_prev, {},
	\bank_next, {},
]);

i.iconTransportFunc[\ctrl_tch_on] = {"Ctrl_tch pressed!".postln };
i.iconTransportFunc[\ctrl_tch_off] = {"Ctrl_tch released!".postln };
i.iconTransportFunc[\ctrl] = {|c| ("Touch Ctrl at: " ++ c ).postln; };
i.iconCtrlReadVal = 0.5;

i.iconTransportFunc[\play] = {"Play".postln};
i.iconTransportFunc[\stop] = {"Stop".postln};
i.iconTransportFunc[\rec] = {"Rec".postln};
i.iconTransportFunc[\cycle] = {"Cycle".postln};
i.iconTransportFunc[\rew] = {"Rew".postln};
i.iconTransportFunc[\fwd] = {"Fwd".postln};
i.iconTransportFunc[\chan_prev] = {"bank_prev".postln};
i.iconTransportFunc[\chan_next] = {"bank_next".postln};
i.iconTransportFunc[\bank_prev] = {"chan_prev".postln};
i.iconTransportFunc[\bank_next] = {"chan_next".postln};



// FUNCTIONS  Transport System Commands
// assign functions:
[\play, \stop, \rec, \cycle, \rew, \fwd, \chan_prev, \chan_next, \bank_prev, \bank_next].do({|c, x|
	var buttonName = c.asSymbol;
	x.postln;
	buttonName.postln;
	i.iconTransportFunc[\play].value;
	~kontrol.elementAt(\tr, buttonName, \on).action_({ |el| i.iconTransportFunc[buttonName].value;});
});

~kontrol.elementAt(\kn_ctrl_tch_on).action_({|el| i.iconTransportFunc[\ctrl_tch_on].value});
~kontrol.elementAt(\kn_ctrl_tch_off).action_({|el| i.iconTransportFunc[\ctrl_tch_off].value});

~kontrol.elementAt(\kn_ctrl).action_({ |el|
	var min, max, value;
	value = el.value.round(0.01);
	// translate encoder in values, store temporary
	if (value>0.3, {min = value.linlin(0.510, 0.64, 0.01, 0.25);
		i.iconCtrlReadVal = (i.iconCtrlReadVal - min).clip2(0.5); });
	if (value<0.3, {max = value.linlin(0.007, 0.09, 0.01, 0.2);
		i.iconCtrlReadVal = (i.iconCtrlReadVal +max).clip2(0.5); });
	// scale to final
	value = (i.iconCtrlReadVal +0.5).round(0.01);
	// store in Array
	i.iconValueArray[\ctrl] = value;
	// evaluate associated function
	i.iconTransportFunc[\ctrl].value(value);
});

)





// SLIDERS / ENCODER
(


//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
// MVC controller
i.iconMVCArray = ();
i.iconMVCArray.putPairs([
	\modelEnc, Ref(Array.fill(9, 0.5)),
	\modelSlider, Ref(Array.fill(9, 1)),
	\mvcEnc, nil,
	\mvcSlider, nil,
	\modelButtons, Ref(Array.fill(32, false)),
	\mvcButtons, nil,
]);

i.iconMVCArray[\mvcEnc] = SimpleController(		i.iconMVCArray[\modelEnc]);
i.iconMVCArray[\mvcSlider] = SimpleController(	i.iconMVCArray[\modelSlider]);
i.iconMVCArray[\mvcButtons] = SimpleController(	i.iconMVCArray[\modelButtons]);



// MVC Functions
i.iconMVCArray[\mvcEnc].put(\val, {|changer|
	//"Enc: ".post;
	i.iconMVCArray[\modelEnc].value_(changer.value);
	8.do({|c|
		defer {g.enc[c].value = changer[c].value};
	});
});
i.iconMVCArray[\mvcSlider].put(\val, {|changer|
	//"Slider: ".post;
	i.iconMVCArray[\modelSlider].value_(changer.value);
	8.do({|c|
		defer {g.slider[c].value = changer[c].value};
		// set motorfader
		defer { ~kontrol.setValueAt(("sl_"++ (c+1)).asSymbol, changer[c].value) };
	});
});
i.iconMVCArray[\mvcButtons].put(\val, {|changer|
	//"Buttons: ".post;
	i.iconMVCArray[\modelButtons].value_(changer.value);
	32.do({|c|
		if (i.iconMVCArray[\modelButtons][c]==true, {
			defer {g.sliderButtons[c].value_(1)};
		});
		if (i.iconMVCArray[\modelButtons][c]==false, {
			defer {g.sliderButtons[c].value_(0)};
		});

	});
});






// init GUI
i.iconMVCReset = {
	i.iconMVCArray[\modelSlider].changed(\val);
	i.iconMVCArray[\modelEnv].changed(\val);
	i.iconMVCArray[\modelButtons].changed(\val);
	i.allButtonsOff.value;
};
i.iconMVCReset.value;








//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
// SLIDER

// Slider Function Array
i.iconSliderFunc = Array.fill(11, nil);
9.do({|c|
	i.iconSliderFunc[c] = {|el| ("Slider " ++ (c+1) ++ " moved! Val: " ++ el).postln};
});
i.iconSliderFunc[9] = {9.do({|c| ~kontrol.setValueAt(("sl_"++ (c+1)).asSymbol, 0);}) };   // setting all sliders to 0
i.iconSliderFunc[10] = {9.do({|c| ~kontrol.setValueAt(("sl_"++ (c+1)).asSymbol, 1);}) };   // setting all sliders to 0
//i.iconSliderFunc[9].value;
//i.iconSliderFunc[10].value;

9.do({|c|
	~kontrol.elementAt(\sl, c).action_({ |el|
		var value = el.value.round(0.01);
		// prevent from moving (done in MVC expept the 9th slider
		if (c==8, {~kontrol.setValueAt(("sl_"++ (c+1)).asSymbol, value);});
		// evaluate associated function
		i.iconSliderFunc[c].value(value);
		// store position in array
		i.iconValueArray[\slider][c] = value;
		// update model
		i.iconMVCArray[\modelSlider].put(c, value).changed(\val);
	});
});
/*
i.iconValueArray.do({|c| c.postln;});
*/




//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
// ENCODER

// Encoder Read
i.iconEncReadVal = [1, 1, 1, 1, 1, 1, 1, 0];
8.do({|c|
	i.iconEncReadVal[c] = i.iconMVCArray[\modelEnc][c] - 0.5;
	i.iconEncVal[c] = i.iconMVCArray[\modelEnc][c];
	i.iconValueArray[\encoder][c] = i.iconMVCArray[\modelEnc][c];
	g.enc[c].value = i.iconMVCArray[\modelEnc][c];
});


i.iconEncSpeed = ();
i.iconEncSpeed.putPairs([
	\left, [0.512, 0.551, 0.598, 0.606],
	\right, [0.008, 0.031, 0.063, 0.078],
]);
// Encoder Function Array
i.iconEncFunc = Array.fill(8, nil);
8.do({|c|
	i.iconEncFunc[c] = {|el|
		("Encoder " ++ (c+1) ++ " moved! Val: " ++ el).postln;
		//b[(\kn ++ c).asSymbol].set(i.iconEncVal[c]);
		//b[("kn" ++ c ++ "Val").asSymbol] = i.iconEncVal[c];
	};
});
// Encoder PUSH Function Array
i.iconEncPushFunc = Array.fill(8, nil);
8.do({|c|
	i.iconEncPushFunc[c] = {|el|
		("Encoder " ++ (c+1) ++ " pushed!").postln;
		i.iconValueArray.do({|c| c.postln;});
	};
});


// assign Movement Encoders to values / functions
8.do({|c|
	~kontrol.elementAt(\kn, c).action_({ |el|
		var min, max, value;
		value = el.value.round(0.01);
		// translate encoder in values, store temporary
		if (value>0.3, {min = value.linlin(0.510, 0.64, 0.01, 0.25);
			i.iconEncReadVal[c]= (i.iconEncReadVal[c]-min).clip2(0.5); });
		if (value<0.3, {max = value.linlin(0.007, 0.09, 0.01, 0.2);
			i.iconEncReadVal[c]= (i.iconEncReadVal[c]+max).clip2(0.5); });
		// scale to final
		value = (i.iconEncReadVal[c]+0.5).round(0.01);
		// store in Array
		i.iconValueArray[\encoder][c] = value;
		// evaluate associated function
		i.iconEncFunc[c].value(value);
		// update model
		i.iconMVCArray[\modelEnc].put(c, value).changed(\val);
	});
});
// assign Push Encoders to values / functions
8.do({|c|
	~kontrol.elementAt(\kn_on, c).action_({ |el|
		i.iconEncPushFunc[c].value;
	});
});

~kontrol.trace(true);
~kontrol.trace(false);
/*
a = MKtl(\midi_1_platfo).desc;
a.postElements;     // post element names and keys/indices in hierarchical order
*/


)





//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
// LevelIndikator

(
// something to meter

b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");

SynthDef(\test, {||
	var colum, noise, imp, delimp, mul = 1;
	imp = Impulse.kr(10);
	delimp = Delay1.kr(imp);
	colum = PlayBuf.ar(1, b, BufRateScale.kr(b), loop: 1) * mul;
	// measure rms and Peak
	SendReply.kr(imp, '/levels', [Amplitude.kr(colum), K2A.ar(Peak.ar(colum, delimp).lag(0, 3))]);
	Out.ar(0, colum);
	Out.ar(1, colum);
}).add;
~synth = Synth(\test)
)


(
o = OSCFunc({arg msg;
	    {
		        g.sliderMeter[6].value = msg[3].ampdb.linlin(-40, 0, 0, 1);
		        g.sliderMeter[6].peakLevel = msg[4].ampdb.linlin(-40, 0, 0, 1);
	    }.defer;
}, '/levels', s.addr);

)





























