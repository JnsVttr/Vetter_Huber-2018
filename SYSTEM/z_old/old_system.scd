
//////////////////////////////////////////////////////////////////
// VETTER_HUBER 2018 --- LIVE SETUP
//////////////////////////////////////////////////////////////////

// START THE SYSTEM
s.meter(0, 14);
s.plotTree;
/*
- arrange strings in GUI
- set empty functions to avoid errors
*/




// SYSTEM



//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// START SERVER + INTERFACES

(
~startRoutine = Routine({

	~system = true; // state that system is not running
	s.waitForBoot;
	2.wait;
	"Server booted".postln;
	MIDIClient.init;
	4.wait;
	"MIDIClient ready".postln;
	~kontrolMidi = MIDIOut.newByName("Platform M+ V1.07", "Platform M+ V1.07", 1506962642);
	MKtl.find;
	3.wait;
	"MKtl ready".postln;
	~kontrol = MKtl('midi_1_platfo', "icon-platform-m-explored");





	//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	// VARIABLES
	i = ();  // init-variables
	a = ();  // sample dictionary
	b = ();  // control Busses for NanoKontrol2
	e = ();  // functions
	//g = ();  // GUI variables
	k;       // variable for NanoKontrol2
	x = ();  // Array for Plazys + SongParts



	//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	// FILES
	"assigning files".postln;
	// Define directories
	g.songDir = thisProcess.nowExecutingPath.dirname +/+ "SONGS/";
	g.songLoad = thisProcess.nowExecutingPath.dirname +/+ "_song-load.scd";
	i.sampleDir = thisProcess.nowExecutingPath.dirname +/+ "AUDIO/";
	i.synthDir = thisProcess.nowExecutingPath.dirname +/+ "SYNTH_DEF/";
	g.presetDir = thisProcess.nowExecutingPath.dirname +/+ "PRESETS/";
	i.mastersynth = thisProcess.nowExecutingPath.dirname +/+ "SYNTH_DEF/synthdefs.scd";
	i.mastersynth.load;

	// SYSTEM FILES
	// Assign Icon Platform M+
	i.iconFile = thisProcess.nowExecutingPath.dirname +/+ "SYSTEM/init-icon.scd";
	//i.iconFile.load;

	// Stop Pattern
	i.stopPattern = thisProcess.nowExecutingPath.dirname +/+ "SYSTEM/stop-pattern.scd";

	i.level = thisProcess.nowExecutingPath.dirname +/+ "SYSTEM/levelIndicator.scd";


	// Start-Boot file
	//i.bootFile = thisProcess.nowExecutingPath.dirname +/+ "SYSTEM/boot-system.scd";
	//i.bootFile.load;

	// Window GUI
	//i.windowFile = thisProcess.nowExecutingPath.dirname +/+ "SYSTEM/_GUI.scd";











	//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	// SAMPLES
	// CHECK
	i.checkSamples = {
		// check samples
		i.sampleFolder = [];
		~sampleCount=0;
		i.sampleFolder = Array.new(100);
		PathName(i.sampleDir).folders.collect({|c|
			"Folder: ".post;
			c.folderName.post;
			i.sampleFolder.add(c.folderName.asString);
			" - ".post;
			c.entries.size.post;
			~sampleCount = ~sampleCount + c.entries.size;
			" Items".postln;
		});
		"- - - - - - - - - - -".postln;
		(PathName(i.sampleDir).folders.size + " Folders | " + ~sampleCount + " Samples").postln;
		"".postln;
		i.sampleFolder.postln;
	}.value;

	// LOAD SAMPLES
	i.loadSamples = {
		// create dictionary
		a = Dictionary.new;
		i.sampleFolder.do({|f|
			f.postln;
			a.add(f.asSymbol -> PathName(i.sampleDir +/+ f.asString).entries.collect({|samples|
				Buffer.read(s, samples.fullPath)}))
		});
		"".postln;
		"-----------------------------------------------------".postln;
		"".postln;
	}.value;
	/*
	a[\kick][1].play;
	*/
	3.wait;
	"SAMPLES LOADED + ASSIGNED!".postln;




	//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	// LOAD SYNTHS

	i.loadSynths = {
		// LOAD SYNTHS before audio
		"-----------------------------------------------------".postln;
		"SYNTH Entries: ".postln;
		PathName(i.synthDir).entries.collect({|c|
			" - ".post;
			c.fileName.post;
			c.fullPath.load;
			("        >>> loaded!").postln;
		});
		"".postln;
	}.value;


	/*
	//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	// PRESETS

	// load preset files
	i.sliderPresetFile = FileReader.read(i.presetDir ++ "/slider_presets.txt", delimiter:$,);
	i.encoderPresetFile = FileReader.read(i.presetDir ++ "/encoder_presets.txt", delimiter:$,);
	i.sliderPresets = ();
	i.encoderPresets = ();

	// search for presets for loaded songs
	i.dynSongName.do({|song|
		if (song!=nil, {
			// Slider
			// check if there are slider presets for songs
			// and save them in local file
			i.sliderPresetFile.do({|presets|
				if (presets[0].asString == song.asString, {
					//"slider for: ".post; song.postln;
					i.sliderPresets.add(song.asSymbol -> Array.fill(8, nil));
					8.do({|c| i.sliderPresets[song.asSymbol].put(c, presets[c+1])});
				});
			});
			i.encoderPresetFile.do({|presets|
				if (presets[0].asString == song.asString, {
					//"encoder for: ".post; song.postln;
					i.encoderPresets.add(song.asSymbol -> Array.fill(8, nil));
					8.do({|c| i.sliderPresets[song.asSymbol].put(c, presets[c+1])});
				});
			});
		});
	});
	"".postln;
	"Slider Presets: ".postln;
	i.dynSongName.do({|song|
		if (song!=nil, {
			song.post;  i.sliderPresets[song.asSymbol].postln;
		});
	});
	"".postln;
	"Encoder Presets: ".postln;
	i.dynSongName.do({|song|
		if (song!=nil, {
			song.post;  i.sliderPresets[song.asSymbol].postln;
		});
	});
	*/







	//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	// SETUP AUDIO ENGINE
	// AUDIO BUSSES
	i.busses = {
		i.kickBus = Bus.audio(numChannels:2);
		i.beatBus = Bus.audio(numChannels:2);
		i.synthBus = Bus.audio(numChannels:2);
		i.melBus = Bus.audio(numChannels:2);

		i.inst0 = Bus.audio(numChannels:2);
		i.inst1 = Bus.audio(numChannels:2);
		i.inst2 = Bus.audio(numChannels:2);
		i.inst3 = Bus.audio(numChannels:2);
		i.inst4 = Bus.audio(numChannels:2);
		i.inst5 = Bus.audio(numChannels:2);
		i.inst6 = Bus.audio(numChannels:2);
		i.inst7 = Bus.audio(numChannels:2);
		i.revBus = Bus.audio(numChannels:2);

		// CONTROL BUSSES for Mix (ICON)
		8.do({|c|
			b[(\sl ++ c).asSymbol] = Bus.control(s);
			b[(\sl ++ c).asSymbol].set(1);
			b[(\kn ++ c).asSymbol]=Bus.control(s);
			b[(\kn ++ c).asSymbol].set(1);
		});
		// Reverb Param
		b[\kn7] = Bus.control(s);
		b[\kn7].set(0.5);

	}.value;




	1.wait;


	//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	// AUDIO ENGINE
	CmdPeriod.run;
	0.1.wait;
	// GROUPS:
	~synths = Group.new(addAction:\addToHead);
	~instrumentGroup = Group.new(~synths, \addAfter);
	~masterGroup = Group.new(addAction:\addToTail);
	~masterGroupOut = Group.new(addAction:\addToTail);

	// INSTRUMENT SYNTHS
	i.inst0Synth = Synth(\instSynth0, [
		\inBus, i.inst0.index, \out, i.synthBus.index, \outRev, i.revBus.index, \filterBus, b[\kn0].index,
		\ampBus, b[\sl0].index, \amp, 1], target: ~instrumentGroup);
	// MEL BUS
	i.inst1Synth = Synth(\instSynth1, [
		\inBus, i.inst1.index, \out, i.melBus.index, \outRev, i.revBus.index, \filterBus, b[\kn1].index,
		\ampBus, b[\sl1].index, \amp, 1], target: ~instrumentGroup);
	i.inst2Synth = Synth(\instSynth2, [
		\inBus, i.inst2.index, \out, i.synthBus.index, \outRev, i.revBus.index, \filterBus, b[\kn2].index,
		\ampBus, b[\sl2].index, \amp, 1], target: ~instrumentGroup);
	i.inst3Synth = Synth(\instSynth3, [
		\inBus, i.inst3.index, \out, i.synthBus.index, \outRev, i.revBus.index, \filterBus, b[\kn3].index,
		\ampBus, b[\sl3].index, \amp, 1], target: ~instrumentGroup);
	i.inst4Synth = Synth(\instSynth4, [
		\inBus, i.inst4.index, \out, i.beatBus.index, \outRev, i.revBus.index, \filterBus, b[\kn4].index,
		\ampBus, b[\sl4].index, \amp, 1], target: ~instrumentGroup);
	i.inst5Synth = Synth(\instSynth5, [
		\inBus, i.inst5.index, \out, i.beatBus.index, \outRev, i.revBus.index, \filterBus, b[\kn5].index,
		\ampBus, b[\sl5].index, \amp, 1], target: ~instrumentGroup);
	i.inst6Synth = Synth(\instSynth6, [
		\inBus, i.inst6.index, \out, i.kickBus.index, \outRev, i.revBus.index, \filterBus, b[\kn6].index,
		\ampBus, b[\sl6].index, \amp, 1], target: ~instrumentGroup);

	// REVERB
	i.reverb = Synth(\reverb, [
		\inBus1, i.revBus.index,
		\out, i.synthBus.index,
		\inAmp, b[\sl7].index,
		\inParam, b[\kn7].index,
		\amp, 1, \revtime, 0.2, \mix, 0.9, \predelay, 0.4
	], target: ~instrumentGroup, addAction:\addToTail); // rev

	// MASTER SYNTH

	~outKick = Synth(\masterSynth, [\inBus, i.kickBus.index, \out, 2], target: ~masterGroup);
	~outBeat = Synth(\masterSynth, [\inBus, i.beatBus.index, \out, 4], target: ~masterGroup);
	~outSynth = Synth(\masterSynth, [\inBus, i.synthBus.index, \out, 6], target: ~masterGroup);
	~outMel = Synth(\masterSynth, [\inBus, i.melBus.index, \out, 8], target: ~masterGroup);

	~masterOut = Synth(\masterOutSynth, [
		\inBus1, 2,
		\inBus2, 4,
		\inBus3, 6,
		\inBus4, 8,
		\out, 0,
		\compression, 0.5,
		\release, 0.15,
		\amp, 1.3],
	target:~masterGroupOut);

	i.level.load;


	s.plotTree;


	/*
	//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	// GUI

	// load file
	i.windowFile.load;

	// title - song
	g.currSongText.string = "- - - ";
	// texts
	g.text[0]; // StaticText Object, 32
	g.textString[0]; // Text 32
	*/

}).play(AppClock);
)

























)
/*
i.audio.value;
b[\kn0].get

i.audio.reset.play;
~masterOut.set(\compression, 0.5, \release, 0.15, \amp, 2)
~reverb.set(\amp, 1, \revtime, 0.2, \mix, 0.9, \predelay, 0.4)
i.inst2.set(\revAmp, 1, \amp, 1)
*/





// TEMPO
TempoClock.default.tempo = (120/30);























//}.play(AppClock)



