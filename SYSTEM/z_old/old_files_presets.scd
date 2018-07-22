
// CREATE PRESET FILES


// central storage place?:
i.iconEncStartVal[\desert].asString

(
// SLIDER - write a test file:
f = File(thisProcess.nowExecutingPath.dirname ++ "/faderpositions.txt", "w");
i.iconSliderVal.keysValuesDo { |n, i|
	n.postln; i.postln;
	f.write(n.asString ++ ",");
	8.do({|c|
		f.write(i[c].asString ++ ",") ;
	});
	f.write(Char.nl)
};
f.close;
)

i.iconSliderVal.keys
i.iconSliderVal.values
i.iconSliderVal.keysValuesDo {|i, v| i.postln; v.postln}





// open file, read and put strings into array, close file.
~trackSlider = FileReader.read(thisProcess.nowExecutingPath.dirname ++ "/faderpositions.txt", delimiter:$,).postcs;
~trackSlider[4][0];
~trackSlider.size;
~track = "desert";
~trackSlPos = Array.fill(8);

(
~trackSlider.do({|i|
	//i.asString.postln;
	//i[0].postln;
	if (i[0].asString == ~track.asString, {
		8.do({|c| ~trackSlPos.put(c, i.[c+1])});
		"SLIDER: ".post;
		i[0].asString.postln;
	});

});
~trackSlPos.postln;
)



(
// ENCODER - write a test file:
f = File(thisProcess.nowExecutingPath.dirname ++ "/encoderpositions.txt", "w");
i.iconEncStartVal.keysValuesDo { |n, i|
	n.postln; i.postln;
	f.write(n.asString ++ ",");
	8.do({|c|
		f.write(i[c].asString ++ ",") ;
	});
	f.write(Char.nl)
};
f.close;
)

// open file, read and put strings into array, close file.
~trackEncoder = FileReader.read(thisProcess.nowExecutingPath.dirname ++ "/encoderpositions.txt", delimiter:$,).postcs;
~trackEncoder[4][0];
~trackEncoder.size;
~track = "desert";
~trackEncPos = Array.fill(8);

(
x.do({|i|
	//i.asString.postln;
	//i[0].postln;
	if (i[0].asString == ~track.asString, {
		8.do({|c| ~trackEncPos.put(c, i.[c+1])});
		"ENCODER: ".post;
		i[0].asString.postln;
	});

});
~trackEncPos.postln;
)