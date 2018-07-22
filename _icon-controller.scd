
////////////////////////////////////////////////////////////////////
// ICON Platform M+ ASSIGN








(
if (n==nil, {n = ();});
n.mixerState = true; // state, that platform M+ is running
g.presetDir = thisProcess.nowExecutingPath.dirname +/+ "PRESETS/";

// MIDI notes/ positions
// Buttons MIDIOut
n.iconVal = ();
n.iconVal.putPairs([
	\rec, [0,1,2,	3,	4,	5,	6,	7],
	\solo, [8,	9,	10,	11,	12,	13,	14,	15],
	\mute, [16,	17,	18,	19,	20,	21,	22,	23],
	\select, [24,	25,	26,	27,	28,	29,	30,	31],
	\push, [32,	33,	34,	35,	36,	37,	38,	39],
	\knob, [16,	17,	18,	19,	20,	21,	22,	23],
]);

// Encoder Speed
n.iconEncSpeed = ();
n.iconEncSpeed.putPairs([
	\left, [0.512, 0.551, 0.598, 0.606],
	\right, [0.008, 0.031, 0.063, 0.078],
]);

//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
// Buttons State Array
n.iconState = ();
n.iconState.putPairs([
	\rec, Array.fill(8, false),
	\solo, Array.fill(8, false),
	\mute, Array.fill(8, false),
	\select, Array.fill(8, false),
]);
// Button On-Function Array
n.iconButtonFuncOn = ();
n.iconButtonFuncOn.putPairs([
	\rec, Array.fill(8, nil),
	\solo, Array.fill(8, nil),
	\mute, Array.fill(8, nil),
	\select, Array.fill(8, nil),
]);
// Button Off-Function Array
n.iconButtonFuncOff = ();
n.iconButtonFuncOff.putPairs([
	\rec, Array.fill(8, nil),
	\solo, Array.fill(8, nil),
	\mute, Array.fill(8, nil),
	\select, Array.fill(8, nil),
]);




//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
// Buttons
n.muteFunction = ();

8.do({|c|
	n.iconButtonFuncOn[\rec][c] = {
		n.iconState[\rec][c] = true;
		~kontrolMidi.noteOn(0, n.iconVal[\rec][c], 1);
		n.changeModel.changed(\changeButtons);
	};
	n.iconButtonFuncOn[\solo][c] = {|val|
		n.iconState[\solo][c] = true;
		if(c<8, {
			if(~system==true, {
				i[("inst" ++ (c) ++ "Synth").asSymbol].set(\revAmp, 0.7);
			});
			//"Reverb on".postln;
		});
		~kontrolMidi.noteOn(0, n.iconVal[\solo][c], 1);
		n.changeModel.changed(\changeButtons);
	};

	// mute functions
	n.muteFunction[c] = {
		e[("in"++c++"Func5").asSymbol].value;
		// switch back normal after 1s
		Routine({
			"mute start".postln;
			0.5.wait;
			4.do({|x|  defer { g.textBlockRef.value_(Ref([x, c, 0])).changed(\val); }; });
			defer { n.iconButtonFuncOff[\mute][c].value; };
			"mute done".postln;
		}).play(AppClock);
	};
	n.iconButtonFuncOn[\mute][c] = {
		n.iconState[\mute][c] = true;
		~kontrolMidi.noteOn(0, n.iconVal[\mute][c], 1);
		n.changeModel.changed(\changeButtons);
		// here mute function

		n.muteFunction[c].value;
		// n.muteFunction[1].value;
	};

	n.iconButtonFuncOn[\select][c] = {|val|
		n.iconState[\select][c] = true;
		~kontrolMidi.noteOn(0, n.iconVal[\select][c], 1);
		n.changeModel.changed(\changeButtons);
	};
});


8.do({|c|
	n.iconButtonFuncOff[\rec][c] = {
		n.iconState[\rec][c] = false;
		~kontrolMidi.noteOn(0, n.iconVal[\rec][c], 0);
		n.changeModel.changed(\changeButtons);
	};
	n.iconButtonFuncOff[\solo][c] = {|val|
		n.iconState[\solo][c] = false;
		if(c<8, {
			if(~system==true, { i[("inst" ++ (c) ++ "Synth").asSymbol].set(\revAmp, 0); });
			//"Reverb off".postln;
		});
		~kontrolMidi.noteOn(0, n.iconVal[\solo][c], 0);
		n.changeModel.changed(\changeButtons);
	};
	n.iconButtonFuncOff[\mute][c] = {
		n.iconState[\mute][c] = false;
		~kontrolMidi.noteOn(0, n.iconVal[\mute][c], 0);
		n.changeModel.changed(\changeButtons);
	};
	n.iconButtonFuncOff[\select][c] = {|val|
		n.iconState[\select][c] = false;
		~kontrolMidi.noteOn(0, n.iconVal[\select][c], 0);
		n.changeModel.changed(\changeButtons);
	};
});

// assign \mute, \solo, \select, \rec Buttons
[\mute, \solo, \select, \rec].do({|c|
	var buttonName = c.asSymbol;
	8.do({|c|
		~kontrol.elementAt(\bt, buttonName, c).action_({ |el|
			if ((el.value==1) && (n.iconState[buttonName][c]==false), {
				n.iconState[buttonName][c] = true;
				n.iconButtonFuncOn[buttonName][c].value(el.value);
			},
			{
				if ((el.value==1) && (n.iconState[buttonName][c]==true), {
					n.iconState[buttonName][c] = false;
					n.iconButtonFuncOff[buttonName][c].value;
				});
			});
		});
	});
});


// all Buttons off
n.allButtonsOff = {
	[\mute, \solo, \select, \rec].do({|c|
		var buttonName = c.asSymbol;
		8.do({|c|
			~kontrolMidi.noteOn(0, n.iconVal[buttonName][c], 0);
			n.iconState[buttonName][c] = false;
		});
		n.changeModel.changed(\changeButtons);
	});
};
n.allButtonsOff.value;









//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
// Select all channels

n.selectAll = false;
n.selectAllFunc = {
	if (n.selectAll==false, {
		8.do({|c|
			~kontrolMidi.noteOn(0, n.iconVal[\select][c], 1);
			n.iconState[\select][c] = true;
		});
		n.changeModel.changed(\changeButtons);
		n.selectAll = true;
	}, {
		8.do({|c|
			~kontrolMidi.noteOn(0, n.iconVal[\select][c], 0);
			n.iconState[\select][c] = false;
		});
		n.changeModel.changed(\changeButtons);
		n.selectAll = false;
	});
};
~kontrol.elementAt(\bt, \master, 2).action_({|el| if (el.value==1, {n.selectAllFunc.value} ) });












// Global Icon value array
n.iconValueArray = ();
n.iconValueArray.putPairs([
	\slider, Array.fill(9, 1),
	\encoder, Array.fill(8, 0.5),
	\ctrl, 1,
]);




//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
// TRANSPORT
/*
a = MKtl(\midi_1_platfo).desc;
a.postElements;     // post element names and keys/indices in hierarchical order
*/


// Transport Functions:

n.iconTransportFunc = ();
n.iconTransportFunc.putPairs([
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

n.iconTransportFunc[\ctrl_tch_on] = {"Ctrl_tch pressed!".postln };
n.iconTransportFunc[\ctrl_tch_off] = {"Ctrl_tch released!".postln };
n.iconTransportFunc[\ctrl] = {|c| ("Touch Ctrl at: " ++ c ).postln; };
n.iconCtrlReadVal = 0.5;



n.startTrack = {
	var startArray, counter;
	startArray = Array.fill(8);
	counter = 0;
	"Play".postln;
	~startTask = Task ({
		[\first, \second, \third, \fourth].do({|name, c|
			name = name.asSymbol;
			8.do({|x|
				x = 7-x;   // important, because reverse order of Pdf execution. Kick needs to start first!
				x.postln;
				if (g.textBlockState[name][x]==1, {
					~textBlockFunc.value(x, c);
					//g.textBlockRef.value_(Ref([c, x, 0])).changed(\val);
				});
			});
		});
	}, AppClock);
	// doesn't work: ~startTask.start(TempoClock.default, 16);
	Pfuncn({ ~startTask.reset.play; nil }, 1).play(quant: (16));
};


n.iconTransportFunc[\play] = {
	if (~songLoaded==true, { Routine({0.1.wait; n.startTrack.value;}).play(AppClock)  }, {".. not jet loaded!".postln;});
};

n.iconTransportFunc[\stop] = {
	"Stop".postln;
	// load stop functions
	i.stopPattern.load;
	[\first, \second, \third, \fourth].do({|name, c|
			8.do({|x|
				g.textBlockRef.value_(Ref([c, x, 0])).changed(\val);
			});
	});

};


n.iconTransportFunc[\rec] = {"Rec".postln};
n.iconTransportFunc[\cycle] = {"Cycle".postln};
n.iconTransportFunc[\rew] = {"Rew".postln};
n.iconTransportFunc[\fwd] = {"Fwd".postln};
n.iconTransportFunc[\bank_prev] = {"chan_prev".postln};
n.iconTransportFunc[\bank_next] = {"chan_next".postln};
n.iconTransportFunc[\chan_prev] = {
	if (g.currSong.value>0, {
		defer { g.currSong.value_(g.currSong.value-1).changed(\val) } ;
	});
};
n.iconTransportFunc[\chan_next] = {
	if (g.currSong.value<g.songCount, {
		defer { g.currSong.value_(g.currSong.value+1).changed(\val) } ;
	});
};






// FUNCTIONS  Transport System Commands
// assign functions:
[\play, \stop, \rec, \cycle, \rew, \fwd, \chan_prev, \chan_next, \bank_prev, \bank_next].do({|c, x|
	var buttonName = c.asSymbol;
	//buttonName.postln;
	~kontrol.elementAt(\tr, buttonName, \on).action_({ |el| n.iconTransportFunc[buttonName].value;});
});

~kontrol.elementAt(\kn_ctrl_tch_on).action_({|el| n.iconTransportFunc[\ctrl_tch_on].value});
~kontrol.elementAt(\kn_ctrl_tch_off).action_({|el| n.iconTransportFunc[\ctrl_tch_off].value});

~kontrol.elementAt(\kn_ctrl).action_({ |el|
	var min, max, value;
	value = el.value.round(0.01);
	// translate encoder in values, store temporary
	if (value>0.3, {min = value.linlin(0.510, 0.64, 0.01, 0.25);
		n.iconCtrlReadVal = (n.iconCtrlReadVal - min).clip2(0.5); });
	if (value<0.3, {max = value.linlin(0.007, 0.09, 0.01, 0.2);
		n.iconCtrlReadVal = (n.iconCtrlReadVal +max).clip2(0.5); });
	// scale to final
	value = (n.iconCtrlReadVal +0.5).round(0.01);
	// store in Array
	n.iconValueArray[\ctrl] = value;
	// evaluate associated function
	n.iconTransportFunc[\ctrl].value(value);
});










//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
// WRITE PRESET
// SLIDER - write a test file:
~writeToFile = {f = File(g.presetDir ++ g.currSongName.asString ++".txt", "w");
	[\slider, \encoder].do({|c, x|
		f.write(c.asString ++ ",");
		8.do({|a|
			f.write((n.iconValueArray[c.asSymbol][a]).asString ++ ",") ;
		});
		f.write(Char.nl)
	});
	[\select, \mute, \solo, \rec].do({|c|
		f.write(c.asString ++ ",");
		8.do({|a|
			f.write((n.iconState[c.asSymbol][a]).asString ++ ",") ;
		});
		f.write(Char.nl)
	});
	[\first, \second, \third, \fourth].do({|name, c|
		f.write(name.asString ++ ",");
		8.do({|a|
			f.write((g.textBlockState[name][a]).asString ++ ",") ;
		});
		f.write(Char.nl)
	});

	f.close;
	".. file written !".postln;
};
//
~kontrol.elementAt(\bt, \master, 0).action_({|el| if (el.value==1, {"Write to file".postln; ~writeToFile.value}) });


//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
// READ FROM SONG PRESET
~textBlockFromPreset = Array.fill(10);

~readFromPreset ={
	Routine({
		if (PathName(g.presetDir ++ g.currSongName.asString ++".txt").isFile==true, {
			f = File(g.presetDir ++ g.currSongName.asString ++".txt", "r");
		},{
			f = File(g.presetDir ++ "default.txt", "r");
			"NO PRESET-FILE JET!".postln;
		});
		~file = FileReader.read(f, delimiter:$,);
		0.02.wait;
		~file.do({|x|
			//x[3].postln;
			switch(x[0].asString,
				"slider".asString, {
					8.do({|c|
						n.iconValueArray[\slider][c] = x.[c+1].asFloat;
						n.iconCurSliderVal[c] = n.iconValueArray[\slider][c];
					});
					0.001.wait;
					n.changeModel.changed(\changeSlider);
				},
				"encoder".asString, {
					8.do({|c|
						n.iconValueArray[\encoder][c] = (x.[c+1]).asFloat;
						// Encoder Read
						n.iconEncReadVal[c] = (n.iconValueArray[\encoder][c]-0.5);
						//"Read Enc Value".postln;
						//n.iconEncReadVal[c].postln;
					});
					//n.iconValueArray[\encoder].postln;
					n.changeModel.changed(\changeEncoder);
				},

				"select".asString, {
					8.do({|c|
						switch(x.[c+1],
							"true", {
								n.iconState[\select][c] = true;
								~kontrolMidi.noteOn(0, n.iconVal[\select][c], 1);
								n.iconButtonFuncOn[\select][c].value;
							},
							"false", {
								n.iconState[\select][c] = false;
								~kontrolMidi.noteOn(0, n.iconVal[\select][c], 0);
								n.iconButtonFuncOff[\select][c].value;
							},
						);
					});
					n.changeModel.changed(\changeButtons);
				},
				"mute".asString, {
					8.do({|c|
						switch(x.[c+1],
							"true", {
								n.iconState[\mute][c] = true;
								~kontrolMidi.noteOn(0, n.iconVal[\mute][c], 1);
								n.iconButtonFuncOn[\mute][c].value;
							},
							"false", {
								n.iconState[\mute][c] = false;
								~kontrolMidi.noteOn(0, n.iconVal[\mute][c], 0);
								n.iconButtonFuncOff[\mute][c].value;
							},
						);
					});
					n.changeModel.changed(\changeButtons);
				},
				"solo".asString, {
					8.do({|c|
						switch(x.[c+1],
							"true", {
								n.iconState[\solo][c] = true;
								~kontrolMidi.noteOn(0, n.iconVal[\solo][c], 1);
								n.iconButtonFuncOn[\solo][c].value;
							},
							"false", {
								n.iconState[\solo][c] = false;
								~kontrolMidi.noteOn(0, n.iconVal[\solo][c], 0);
								n.iconButtonFuncOff[\solo][c].value;
							},
						);
					});
					n.changeModel.changed(\changeButtons);
				},
				"rec".asString, {
					8.do({|c|
						switch(x.[c+1],
							"true", {
								n.iconState[\rec][c] = true;
								~kontrolMidi.noteOn(0, n.iconVal[\rec][c], 1);
								n.iconButtonFuncOn[\rec][c].value;
							},
							"false", {
								n.iconState[\rec][c] = false;
								~kontrolMidi.noteOn(0, n.iconVal[\rec][c], 0);
								n.iconButtonFuncOff[\rec][c].value;
							},
						);
					});
					n.changeModel.changed(\changeButtons);
				},

				"first".asString, {
					Routine{
					8.do({|c|
							0.003.wait;
						switch(x.[c+1],
							"0", {},
							"1", {},
							"2", {
								g.textBlockRef.value_(Ref([0, c, 1])).changed(\val);
							},
						);
					});
					}.play(AppClock);
				},
				"second".asString, {
					Routine{
					8.do({|c|
							0.003.wait;
						switch(x.[c+1],
							"0", {},
							"1", {},
							"2", {
								g.textBlockRef.value_(Ref([1, c, 1])).changed(\val);
							},
						);
					});
					}.play(AppClock);
				},
				"third".asString, {
					Routine{
					8.do({|c|
							0.003.wait;
						switch(x.[c+1],
							"0", {},
							"1", {},
							"2", {
								g.textBlockRef.value_(Ref([2, c, 1])).changed(\val);
							},
						);
					});
					}.play(AppClock);
				},
				"fourth".asString, {
					Routine{
					8.do({|c|
							0.003.wait;
						switch(x.[c+1],
							"0", {},
							"1", {},
							"2", {
								g.textBlockRef.value_(Ref([3, c, 1])).changed(\val);
							},
						);
					});
					}.play(AppClock);
				},
			);
		});
		"".postln;
		".. FILE LOADED!".postln;
		n.resetSlider.value;
		n.changeModel.changed(\changeButtons);
		f.close;
	}).play(AppClock);
};


//~readFromPreset.value;
/*
g.textBlockRef.value_(Ref([2, 1, 1])).changed(\val);
*/


n.resetSlider = {
	8.do({|c|
		var num = c+1;
		~kontrol.setValueAt(("sl_"++ num).asSymbol, (n.iconValueArray[\slider][c]).asFloat);
	});
	n.changeModel.changed(\changeSlider);
};










//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
// SLIDER

// value for changing multiple sliders
n.iconCurSliderVal = Array.fill(8, 1);


// Slider Function Array
n.iconSliderFunc = Array.fill(11, nil);
8.do({|c|
	n.iconSliderFunc[c] = {|el|
		n.changeModel.changed(\changeSlider);
		//("Slider " ++ (c+1) ++ " moved! Val: " ++ el).postln;
		if (~system==true, {b[(\sl ++ c).asSymbol].set(el);});
		// saving value
		n.iconCurSliderVal[c] = el.value.round(0.01);
		//("Slider "++c++" Val: "++el).postln;
	};
});

n.iconSliderFunc[9] = {9.do({|c| ~kontrol.setValueAt(("sl_"++ (c+1)).asSymbol, 0);}) };   // setting all sliders to 0
n.iconSliderFunc[10] = {9.do({|c| ~kontrol.setValueAt(("sl_"++ (c+1)).asSymbol, 1);}) };   // setting all sliders to 0
n.iconSliderFunc[9].value;

8.do({|c|
	~kontrol.elementAt(\sl, c).action_({ |el|
		var value = el.value.round(0.01);
		// evaluate associated function
		n.iconSliderFunc[c].value(value);
		// store position in array
		n.iconValueArray[\slider][c] = value;
		~kontrol.setValueAt(("sl_"++ (c+1)).asSymbol, n.iconValueArray[\slider][c]);  // prevent moving
	});
});

~kontrol.elementAt(\sl, 8).action_({|el|
	~kontrol.setValueAt(\sl_9, el.value);   // prevent moving
	// store position in array
	n.iconValueArray[\slider][8] = el.value.round(0.01);
	// update sliders
	8.do({|c|
		if (n.iconState[\select][c]==true, {
			var newVal;
			if (el.value<0.05, {newVal = 0; }, {
				newVal = el.value.linlin(0, 1, 0, n.iconCurSliderVal[c]);
			});
			~kontrol.setValueAt(("sl_"++ (c+1)).asSymbol, newVal);
			n.iconValueArray[\slider][c] = newVal.round(0.001);
			//n.changeModel.changed(\changeSlider);
			//if (~system==true, { b[(\sl ++ c).asSymbol].set(el.value.linlin(0, 1, 0, n.iconCurSliderVal[c]));  });
			if (~system==true, { b[(\sl ++ c).asSymbol].set(newVal);  });
		});
	});
});









//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
// ENCODER

// Encoder Read
n.iconEncReadVal = n.iconValueArray[\encoder]-0.5;

// Encoder Function Array
n.iconEncFunc = Array.fill(8, nil);
8.do({|c|
	n.iconEncFunc[c] = {|el|
		n.changeModel.changed(\changeEncoder);
		//("Encoder " ++ (c+1) ++ " moved! Val: " ++ el).postln;
	};
});
// Encoder PUSH Function Array
n.iconEncPushFunc = Array.fill(8, nil);
8.do({|c|
	n.iconEncPushFunc[c] = {|el|
		("Encoder " ++ (c+1) ++ " pushed!").postln;
		//n.iconValueArray.do({|c| c.postln;});
	};
});


// assign Movement Encoders to values / functions
8.do({|c|
	~kontrol.elementAt(\kn, c).action_({ |el|
		var min, max, value;
		value = el.value.round(0.01);
		// translate encoder in values, store temporary
		if (value>0.3, {min = value.linlin(0.510, 0.64, 0.01, 0.25);
			n.iconEncReadVal[c]= (n.iconEncReadVal[c]-min).clip2(0.5); });
		if (value<0.3, {max = value.linlin(0.007, 0.09, 0.01, 0.2);
			n.iconEncReadVal[c]= (n.iconEncReadVal[c]+max).clip2(0.5); });
		// scale to final
		value = (n.iconEncReadVal[c]+0.5).round(0.01);
		// store in Array
		n.iconValueArray[\encoder][c] = value;
		// evaluate associated function
		n.iconEncFunc[c].value(value);
	});
});
// assign Push Encoders to values / functions
8.do({|c|
	~kontrol.elementAt(\kn_on, c).action_({ |el|
		n.iconEncPushFunc[c].value;
	});
});


n.resetEncoder = {|x|
	8.do({|c|
		if (x==nil, {
			n.iconValueArray[\encoder][c] = 0.5;
		});
		if (x==1, {
			// read from array iconValueArray[\encoder]
		});
	});
	n.changeModel.changed(\changeSlider);
}.value(1);








//= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
// SONG CHANGE

n.changeModel = Ref;
if (n.changeGUIButtons==nil, {
	n.changeGUIButtons = SimpleController(n.changeModel);
});
n.changeGUIButtons.put(\changeButtons, {|changer|
	if(g!=nil, {
		n.iconState[\select].do({|x, c|
			if (x==true, {
				defer { g.sliderButtons[c].value_(1) }
			}, {
				defer { g.sliderButtons[c].value_(0) }
			});
		});
		n.iconState[\mute].do({|x, c|
			if (x==true, {
				defer { g.sliderButtons[c+8].value_(1) }
			}, {
				defer { g.sliderButtons[c+8].value_(0) }
			});
		});
		n.iconState[\solo].do({|x, c|
			if (x==true, {
				defer { g.sliderButtons[c+16].value_(1) }
			}, {
				defer { g.sliderButtons[c+16].value_(0) }
			});
		});
		n.iconState[\rec].do({|x, c|
			if (x==true, {
				defer { g.sliderButtons[c+24].value_(1) }
			}, {
				defer { g.sliderButtons[c+24].value_(0) }
			});
		});


	});
});
n.changeModel.changed(\changeButtons);

// change Slider
n.changeGUIButtons.put(\changeSlider, {|changer|
	//"Change Slider".postln;
	8.do({|c|
		defer {  g.slider[c].value_(n.iconValueArray[\slider][c]) };
		if (~system==true, { b[(\sl ++ c).asSymbol].set(n.iconValueArray[\slider][c]); });
	});
});
n.changeModel.changed(\changeSlider);

// change Buttons
n.changeGUIButtons.put(\changeEncoder, {|changer|
	//"Change Encoder".postln;
	8.do({|c|
		defer {  g.enc[c].value_(n.iconValueArray[\encoder][c]) };
		if (~system==true, { b[(\kn ++ c).asSymbol].set(n.iconValueArray[\encoder][c]);  });
	});
});
n.changeModel.changed(\changeEncoder);








// EOF
)







