// GUI - dev



(

if(~varInit!=true, {
	g = (); // gui
	k = (); // keyboard interaction
	e = ();
	i = ();  // init-variables
	a = ();  // sample dictionary
	b = ();  // control Busses for NanoKontrol2
	e = ();  // functions
	//g = ();  // GUI variables
	k;       // variable for NanoKontrol2
	x = ();  // Array for Plazys + SongParts
}); // remove later

g.songLoad = thisProcess.nowExecutingPath.dirname +/+ "SYSTEM/_song-load.scd";
g.presetDir = thisProcess.nowExecutingPath.dirname +/+ "PRESETS/";
i.stopPattern = thisProcess.nowExecutingPath.dirname +/+ "SYSTEM/stop-pattern.scd";


g.guiState = true; // state, that GUI is ready
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //





//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// SONGS

g.songDir = thisProcess.nowExecutingPath.dirname +/+ "SONGS/";
g.songCount = 0;
g.songName = Array.fill(30);
g.songFileName = Array.fill(30);


"".postln;
"- - - - - - - - - - - - - - - -".postln;
"SONGS:".postln;
"".postln;
PathName(g.songDir).entries.collect({|c, x|
	var name, fileName, counter;
	counter = x;
	// save song file name
	fileName = c.fileName;
	g.songFileName.put(x, fileName);
	// save song name
	name = c.fileNameWithoutExtension;
	name = name.split($ )[1].replace("-", " ").postln;
	g.songName.put(x, name);
	// count songs
	g.songCount = g.songCount +1;
});
"".postln;
("Found Song total: ").post; g.songCount.postln;
"".postln;
"".postln;




// main window
g.mainWidth = 1300;
g.mainHeight = 1000;
g.main= Window.new("VETTER_HUBER LIVE GUI", Rect(1200, 600, g.mainWidth, g.mainHeight))
.front
.background_(Color.black);
g.main.onClose_({ g.main=nil }); //close the window and the synth plays

// headline
g.headline = CompositeView.new(g.main, Rect(0, 20, 500, 80)).background_(Color.black);
g.headlineText = StaticText(g.headline, Rect(0, 0, 500, 80)).string_("VETTER_HUBER").stringColor_(Color.grey);
g.headlineText.align = \center;
g.headlineText.font = Font("Helvetica", 51);

// current Song
g.currSongView = CompositeView.new(g.main, Rect(520, 20, 500, 80)).background_(Color.black);
g.currSongText = StaticText(g.currSongView, Rect(0, 0, 500, 80)).stringColor_(Color.grey);
g.currSongText.align = \center;
g.currSongText.font = Font("Helvetica", 41);
g.currSongText.string = "default";


// Song Tempo
g.tempoView = CompositeView.new(g.main, Rect(1020, 20, 200, 80)).background_(Color.black);
g.tempoText = StaticText(g.tempoView, Rect(0, 0, 200, 80)).stringColor_(Color.grey)
.align_(\center)
.font_(Font("Helvetica", 21))
.string_("120 BPM");


// Notes View
g.notesView = CompositeView.new(g.main, Rect(310, 750, 760, 200)).background_(Color.black);
g.notesText = StaticText(g.notesView, Rect(0, 0, 760, 200)).stringColor_(Color.grey)
.align_(\left)
.font_(Font("Helvetica", 21))
.string_("- - - ");





// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// Level Meter
g.levelStereo = CompositeView.new(g.main, Rect(1120, 240, 100, 320)).background_(Color.black);
g.levelStereoMeter = ServerMeterView.new(s, g.levelStereo, 5@0, 0, 2);
g.levelStereoText = StaticText(g.levelStereo, Rect(0, 200, 100, 50)).stringColor_(Color.white);
g.levelStereoText.align = \center;
g.levelStereoText.font = Font("Helvetica", 12);
g.levelStereoText.string = "> >";
g.levelStereo.visible_(false);


// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// Level Meter // NEU
g.level = CompositeView.new(g.main, Rect(1020, 240, 300, 280)).background_(Color.black);
g.levelMeter = ServerMeterView.new(s, g.level, 5@0, 0, 12);
g.levelText = StaticText(g.level, Rect(0, 200, 300, 50)).stringColor_(Color.white);
g.levelText.align = \center;
g.levelText.font = Font("Helvetica", 12);
g.levelText.string = ">>     kick     snare    bass    synth   M_R   ";
g.level.visible_(true);



// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// SERVER SYSTEM view
g.system = CompositeView.new(g.main, Rect(1100, 520, 170, 220)).background_(Color.black)
.mouseDownAction_({g.focusAction[1].value});
g.system.decorator = FlowLayout( g.system.bounds, 0@0, 20@5 );
g.systemText = Array.fill(10);
g.systemButton = Array.fill(10);
g.systemButtonColor = [Color.white, Color.grey, Color.green];
7.do({|c|
	// Text
	g.systemText[c] = StaticText(g.system, 130@20, 10@10).background_(Color.black).string_("system").stringColor_(Color.grey).align_(\right);
	g.systemButton[c] = Button(g.system, 18@18, 10@10).states_([
		["", Color.black, g.systemButtonColor[0]],
		["L", Color.black, g.systemButtonColor[1]],
		["R", Color.black, g.systemButtonColor[2]],
	]).action_({|butt|
		//butt.value.postln;
		switch(butt.value,
			0, {g.systemStartTasks[c].reset.play},
			1, {g.systemStartTasks[c].reset.play}
		);
	});

});
g.systemText[0].string_("Connect MIDI/ MKtl");
g.systemText[1].string_("Load Interaction");
g.systemText[2].string_("Boot the system");
g.systemText[3].string_("(RE)Start audio");
g.systemText[4].string_("Standby");
g.systemText[5].string_("s.Meter");
g.systemText[6].string_("Mixer GUI");
// show serverMeter
g.systemButton[5]
.states_([
	["", Color.black, g.systemButtonColor[0]],
	["S", Color.black, g.systemButtonColor[1]],
	["R", Color.black, g.systemButtonColor[2]],
])
.action_({|butt|
	switch(butt.value,
		0, {g.level.visible_(false); g.levelStereo.visible_(false); g.levelStereo.visible_(false)},
		1, {g.levelStereo.visible_(true); g.level.visible_(false)},
		2, {g.level.visible_(true)},
	);
});
g.systemButton[5].value_(2);
// show GUI
g.systemButton[6]
.states_([
	["", Color.black, g.systemButtonColor[0]],
	["R", Color.black, g.systemButtonColor[2]],
])
.action_({|butt|
	switch(butt.value,
		0, {g.sliderView.visible_(false)},
		1, {g.sliderView.visible_(true)},
	);
});
g.systemButton[6].value_(1);



// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// MASTER COMPRESSOR
g.master = CompositeView.new(g.main, Rect(1100, 720, 170, 130)).background_(Color.black)
.mouseDownAction_({g.focusAction[1].value});
g.master.decorator = FlowLayout( g.master.bounds, 0@0, 20@5 );
g.masterText = Array.fill(10);
g.masterButton = Array.fill(10);
g.masterButtonColor = [Color.black, Color.new255(15, 15, 15), Color.blue];
5.do({|c|
	// Text
	g.masterText[c] = StaticText(g.master, 130@20, 10@10).background_(Color.black).string_("system").stringColor_(Color.grey).align_(\right);
	g.masterButton[c] = Button(g.master, 18@18, 10@10).states_([
		["", Color.white, g.masterButtonColor[0]],
		["C", Color.white, g.masterButtonColor[2]],
	]).action_({|butt|
		//butt.value.postln;

		switch(butt.value,
			0, {},
			1, {("compressor setting Nr. "++c).postln;i.compMaster[c].value; 5.do({|x| if (x!=c, {g.masterButton[x].value_(0);})});}
		);
	});

});
g.masterText[0].string_("comp > without");
g.masterText[1].string_("comp > kicky");
g.masterText[2].string_("comp > smooth");
g.masterText[3].string_("comp > black hole");
g.masterText[4].string_("comp > massive");


if(~system==true, {g.masterButton[1].value_(1)});





// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// INTERACTION window
g.interact = CompositeView.new(g.main, Rect(250, 150, 770, 550)).background_(Color.black).mouseDownAction_({g.focusAction[1].value});
// including text/ slider/ encoder

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// ENCODER
g.enc = Array.fill(8);
g.encVal = Array.fill(8);
g.encFunc = Array.fill(8);
8.do({|c|
	g.encFunc[c] = {|val| ("Enc "++c++" Val: "++val).postln};
});

// view
g.encView = CompositeView.new(g.interact, Rect(0, 0, 800, 70)).background_(Color.black);
g.encView.decorator = FlowLayout( g.encView.bounds, 40@10, 40@20 );
8.do({|c|
	g.enc[c] = Knob.new(g.encView, 50@50 ).action_({|v|
		g.encFunc[c].value(v.value);
	});
});




// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// SLIDER
g.slider = Array.fill(8);
g.sliderView = Array.fill(8);
g.sliderVal = Array.fill(8);
g.sliderFunc = Array.fill(8);
g.sliderStrips = Array.fill(8);
g.sliderButtonView = Array.fill(8);
g.sliderButtonViewFlow = Array.fill(8);
g.sliderButtonsCount = 0;
g.sliderButtons = Array.fill(32);
g.sliderMeter = Array.fill(8);

8.do({|c|
	g.sliderFunc[c] = {|val| ("Slider "++c++" Val: "++val).postln};
});


// view
g.sliderView = CompositeView.new(g.interact, Rect(25, 70, 750, 270)).background_(Color.black);
g.sliderView.decorator = FlowLayout( g.sliderView.bounds, 10@10, 5@2 );
8.do({|c|
	g.sliderStrips[c] = CompositeView (g.sliderView, Rect(0, 0, 86, 220)).background_(Color.black);
	g.sliderStrips[c].decorator = FlowLayout( g.sliderView.bounds, 0@0, 5@2 );
	// first slider
	g.slider[c] = Slider( g.sliderStrips[c], 15@220).background_( Color.new255(26, 26, 26) ).knobColor_(Color.black).thumbSize_(30)
	.action_({|v|
		var val = v.value.postln;
		g.sliderFunc[c].value(val);
	});
	// Buttons
	g.sliderButtonView[c] = CompositeView (g.sliderStrips[c], Rect(0, 0, 26, 100)).background_(Color.black);
	g.sliderButtonView[c].decorator = d = FlowLayout( g.sliderStrips[c].bounds, 0@0, 5@2 );
	4.do({|x|
		g.sliderButtonsCount = (x * 8) +c;
		g.sliderButtons[g.sliderButtonsCount] = Button(g.sliderButtonView[c], 20@20).states_([ [" ", Color.black, Color.black] ]);
		d.nextLine;
	});
	// Levelmeter
	g.sliderMeter[c] = LevelIndicator(g.sliderStrips[c], Rect(0, 150, 3, 220))
	.background_(Color.clear)
	.drawsPeak_(true)
	.style_(\led)
	.warning_(-5.dbamp)
	.critical_(-2.dbamp)
	.numSteps_(15);

});

32.do({|c|
	if ((c>=0)&&(c<=7),
		{ g.sliderButtons[c].states_([ ["SE", Color.black, Color.black], ["SE", Color.black, Color.red] ]);
	});
	if ((c>=8)&&(c<=15),
		{ g.sliderButtons[c].states_([ ["M", Color.black, Color.black], ["M", Color.black, Color.blue] ]);
	});
	if ((c>=16)&&(c<=23),
		{ g.sliderButtons[c].states_([ ["S", Color.black, Color.black], ["S", Color.black, Color.green] ]);
	});
	if ((c>=24)&&(c<=31),
		{ g.sliderButtons[c].states_([ ["R", Color.black, Color.black], ["R", Color.black, Color.red] ]);
	});
});




// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// TEXTS
g.text = ();
g.text.putPairs([
	\first, Array.fill(8),
	\second, Array.fill(8),
	\third, Array.fill(8),
	\fourth, Array.fill(8),
]);

g.textColorText = [Color.white, Color.black, Color.gray, Color.red];
g.textColorBack = [Color.white, Color.black, Color.gray, Color.red];

// view
g.textView = CompositeView.new(g.interact, Rect(0, 330, 780, 300)).background_(Color.black).mouseDownAction_({g.focusAction[1].value});
g.textView.decorator = FlowLayout( g.textView.bounds, 4@4, 2@2 );
[\fourth, \third, \second, \first].do({|row|
	8.do({|c|
		g.text[row.asSymbol][c] = StaticText( g.textView ,92@50 ).background_( Color.black )
		.string_(".")
		.stringColor_(Color.white)
		.align_(\center)
		.font_(Font("Helvetica", 19));
	});
});

//g.text[0][0].background_(Color.green)
//g.text[\first][1].background_(Color.green);


// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// SONG window
g.songColorText = [Color.white, Color.black, Color.gray, Color.red];
g.songColorBackground = [Color.white, Color.black, Color.gray, Color.red];
g.songButton = Array.fill(g.songCount);
g.songButtonFunc = Array.fill(g.songCount);

g.currSong = Ref(0);
g.currSong.value_(3);
g.currSong.changed(\val);
g.currSongMVC = SimpleController(g.currSong);
g.currSongMVC.put(\val, {|changer|
	g.currSong.value = changer.value;
	g.songCount.do({|c|
		if (c==g.currSong.value, {
			g.songButton[c].value = 1;
			g.currSongText.string = g.songName[c];
			//(""++g.currSongText.string++" load:").postln;
			g.songLoad.load;

			// load in Quant
			//Pfuncn({ g.songLoad.load; nil }, 1).play(quant: ( 4));
			g.currSongName = g.songName[g.currSong.value];
		},{
			g.songButton[c].value = 0;
		});
	});
});


g.songsView = CompositeView.new(g.main, Rect(30, 150, 200, 750)).background_(Color.black)
.mouseDownAction_({g.focusAction[1].value});
g.songsView.decorator = FlowLayout(g.songsView.bounds, 0@0, 20@20);
g.songCount.do({|c|
	g.songButton[c] = Button( g.songsView ,200@30 )
	.background_(Color.black).states_([
		[((c+1).asString ++ " " ++ g.songName[c]).asString, g.songColorText[0], g.songColorBackground[1]],
		[((c+1).asString ++ " " ++ g.songName[c]).asString, g.songColorText[1], g.songColorBackground[2]]
	])
	.action_({
		g.songButtonFunc[c].value;
		g.currSong.value = c;
		g.currSong.changed(\val);
	});

});


// load first song
//g.songButtonFunc[0].value;
//g.currSong.value_(0).changed(\val);





// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// Keyboard Interaction
KeyCodeResponder.clear;
/*
KeyCodeResponder.tester
n = ()
*/
g.ctrlFunc = {
	"Stop".postln;
	// load stop functions
	i.stopPattern.load;
	[\first, \second, \third, \fourth].do({|name, c|
		name = name.asSymbol;
		8.do({|x|
			if (g.textBlockState[name][x]==1, {
				~textBlockFunc.value(x, c)
				//g.textBlockRef.value_(Ref([c, x, 0])).changed(\val);
			});
		});
	});
};




// TEXT BLOCK FUNCTIONS
// - - - - - - - - - - - - - - - - -
// TEXT BLOCK LOGIC
g.textBlockState = ();   // 0=not, 1=selected, 2=playing
g.textBlockState.putPairs([
	\first, Array.fill(8, 0),
	\second, Array.fill(8, 0),
	\third, Array.fill(8, 0),
	\fourth, Array.fill(8, 0),
]);
g.textBlockStateColor = [Color.black, Color.new255(28, 28, 28), Color.gray];
g.textBlockStateColorText = [Color.white, Color.gray, Color.new255(28, 28, 28), Color.new255(0, 134, 139)];
g.textBlockRef = Ref([1, 2, 2]);
g.textBlockMVC = SimpleController(g.textBlockRef);
g.textBlockMVC.put(\val, {|changer|
	var row, pos, state, name;
	//changer.value.postln;
	row = changer.value[0];
	pos = changer.value[1];
	state = changer.value[2];
	switch(row,
		0, {name = \first},
		1, {name = \second},
		2, {name = \third},
		3, {name = \fourth},
	);
	switch(state,
		0, {
			g.textBlockState[name.asSymbol][pos] = 0;
			defer { g.text[name][pos].background_(g.textBlockStateColor[0]) };
			defer { g.text[name][pos].stringColor_(g.textBlockStateColorText[1]) }
		},
		1, {
			g.textBlockState[name.asSymbol][pos] = 1;
			defer { g.text[name][pos].background_(g.textBlockStateColor[0]) };
			defer { g.text[name][pos].stringColor_(g.textBlockStateColorText[3]) }
		},
		2, {
			//"START SOUND HERE".postln;
			g.textBlockState[name.asSymbol][pos] = 2;
			defer { g.text[name][pos].background_(g.textBlockStateColor[0]) };
			defer { g.text[name][pos].stringColor_(g.textBlockStateColorText[0]) }
		},
	);
	//g.textBlockState.postln;
});

/*
g.text[\first][5].stringColor_(g.textBlockStateColorText[1])
*/

// KEYBOARD FUNCTIONS
~textBlockFunc = {|pos, row|
	//"StartSound Here & now!".postln;
	("e[/" ++ "in"++pos++"Func"++(row+1)++"].value").postln;
	e[("in"++pos++"Func"++(row+1)).asSymbol].value;
	if(pos<8, {
		4.do({|c|  defer { g.textBlockRef.value_(Ref([c, pos, 0])).changed(\val); }; });
		defer { g.textBlockRef.value_(Ref([row, pos, 2])).changed(\val); };
	});
};



// Numpad Function
~numpadFunc = {|val|
	// original func:
	e[("num"++val++"DownFunc").asSymbol].value;
};




// Shift + Numbers - Song select
~shiftNumberFunc = {|val|
	if (val<=g.songCount, {
		//g.songButtonFunc[c].value;
		g.currSong.value_(val).changed(\val);
	});
};


g.getKey= UserView.new(g.main, Rect(20, 900, 230, 50)).background_(Color.new255(28, 28, 28))
.focus
.keyDownAction_(
	KeyCodeResponder.new
	// Numpad Codes
	.normal( 82 -> { ~numpadFunc.value(0)})
	.normal( 83 -> { ~numpadFunc.value(1)})
	.normal( 84 -> { ~numpadFunc.value(2)})
	.normal( 85 -> { ~numpadFunc.value(3)})
	.normal( 86 -> { ~numpadFunc.value(4)})
	.normal( 87 -> { ~numpadFunc.value(5)})
	.normal( 88 -> { ~numpadFunc.value(6)})
	.normal( 89 -> { ~numpadFunc.value(7)})
	.normal( 91 -> { ~numpadFunc.value(8)})
	.normal( 92 -> { ~numpadFunc.value(9)})
	// Letter-Pairs e[("in0Func"++c).asSymbol].value
	// yaq, xsw, cde, vfr, bgt, nhz, mju
	.normal(6->  {~textBlockFunc.value(0,0)}).normal(0->   {~textBlockFunc.value(0,1) }).normal(12-> {~textBlockFunc.value(0,2)})
	.normal(7->  {~textBlockFunc.value(1,0)}).normal(1->   {~textBlockFunc.value(1,1) }).normal(13-> {~textBlockFunc.value(1,2)})
	.normal(8->  {~textBlockFunc.value(2,0)}).normal(2->   {~textBlockFunc.value(2,1) }).normal(14-> {~textBlockFunc.value(2,2)})
	.normal(9->  {~textBlockFunc.value(3,0)}).normal(3->  {~textBlockFunc.value(3,1)}).normal(15-> {~textBlockFunc.value(3,2)})
	.normal(11-> {~textBlockFunc.value(4,0)}).normal(5->  {~textBlockFunc.value(4,1)}).normal(17-> {~textBlockFunc.value(4,2)})
	.normal(45-> {~textBlockFunc.value(5,0)}).normal(4->  {~textBlockFunc.value(5,1)}).normal(16-> {~textBlockFunc.value(5,2)})
	.normal(46-> {~textBlockFunc.value(6,0)}).normal(38-> {~textBlockFunc.value(6,1)}).normal(32-> {~textBlockFunc.value(6,2)})
	// extra
	// ,ki .lo äü
	.normal(43-> {~textBlockFunc.value(7,0)}).normal(40-> {~textBlockFunc.value(7,1)}).normal(34-> {~textBlockFunc.value(7,2)})
	.normal(47-> {~textBlockFunc.value(8,0)}).normal(37-> {~textBlockFunc.value(8,1)}).normal(31-> {~textBlockFunc.value(8,2)})
	.normal(44-> {~textBlockFunc.value(9,0)}).normal(41-> {~textBlockFunc.value(9,1)}).normal(35-> {~textBlockFunc.value(9,2)})
											 .normal(39-> {~textBlockFunc.value(10,1)}).normal(33-> {~textBlockFunc.value(10,2)})
	// assign normal numbers 1-0
	.normal( 18 -> {~textBlockFunc.value(0,3)})
	.normal( 19 -> {~textBlockFunc.value(1,3)})
	.normal( 20 -> {~textBlockFunc.value(2,3)})
	.normal( 21 -> {~textBlockFunc.value(3,3)})
	.normal( 23 -> {~textBlockFunc.value(4,3)})
	.normal( 22 -> {~textBlockFunc.value(5,3)})
	.normal( 26 -> {~textBlockFunc.value(6,3)})
	.normal( 28 -> {~textBlockFunc.value(7,3)})
	.normal( 25 -> {~textBlockFunc.value(8,3)})
	.normal( 29 -> {~textBlockFunc.value(9,3)})
	.normal( 27 -> {~textBlockFunc.value(10,3)})
	// start preset
	.register( 36, false, false, false, false, {n.startTrack.value;})
	// assign SHIFT normal numbers 1-0
	.shift( 18 -> { ~shiftNumberFunc.value(0) })
	.shift( 19 -> { ~shiftNumberFunc.value(1) })
	.shift( 20 -> { ~shiftNumberFunc.value(2) })
	.shift( 21 -> { ~shiftNumberFunc.value(3) })
	.shift( 23 -> { ~shiftNumberFunc.value(4) })
	.shift( 22 -> { ~shiftNumberFunc.value(5)})
	.shift( 26 -> { ~shiftNumberFunc.value(6) })
	.shift( 28 -> { ~shiftNumberFunc.value(7) })
	.shift( 25 -> { ~shiftNumberFunc.value(8) })
	.shift( 29 -> { ~shiftNumberFunc.value(9) })
	.shift( 27 -> { ~shiftNumberFunc.value(10) })
	// Stop all Pdefs with "Control" Key
	.register( 0, false, false, false, true, {g.ctrlFunc.value})
	// save start selection for preset
	.register(   53  ,   false, false, false, false, {g.getKey.focus; g.focusAction[0].value})
)
.mouseDownAction_({g.focusAction[0].value})
.focusLostAction_({g.focusAction[1].value});

/*
KeyCodeResponder.tester
g.getKey.focus
*/



g.focusText = StaticText(g.getKey, Rect(0, 0, 230, 50)).stringColor_(Color.white).align_(\center)
.string_("");




g.focusAction = [
	{"Focus > > > ON".postln; g.focusText.string_("> > >")},
	{"Focus LOST".postln; g.focusText.string_("")}
];





// EOF

)

//n.startTrack.value;


