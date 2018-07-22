
//////////////////////////////////////////////////////////////////
// VETTER_HUBER 2018 --- LIVE SETUP
// code by Jens Vetter, Linz July 2018
// jensvetter@ymail.com
// https://jensvetter.de
//////////////////////////////////////////////////////////////////







// START THE SYSTEM
(
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// LOAD HERE








// have fun : )







// VARIABLES
if (~system!=true, {
	i = ();  // init-variables
	a = ();  // sample dictionary
	b = ();  // control Busses for NanoKontrol2
	e = ();  // functions
	g = ();  // GUI variables
	k;       // variable for NanoKontrol2
	x = ();  // Array for Plazys + SongParts
	~varInit = true;
});


// Define Directories
g.songDir = thisProcess.nowExecutingPath.dirname +/+ "SONGS/";
i.sampleDir = thisProcess.nowExecutingPath.dirname +/+ "AUDIO/";
i.synthDir = thisProcess.nowExecutingPath.dirname +/+ "SYNTH_DEF/";
g.presetDir = thisProcess.nowExecutingPath.dirname +/+ "PRESETS/";

// Define System Files
i.guiFile = thisProcess.nowExecutingPath.dirname +/+ "_GUI.scd";
i.iconFile = thisProcess.nowExecutingPath.dirname +/+ "_icon-controller.scd";

// Define Utilities
g.songLoad = thisProcess.nowExecutingPath.dirname +/+ "SYSTEM/_song-load.scd";
i.mastersynth = thisProcess.nowExecutingPath.dirname +/+ "SYNTH_DEF/synthdefs.scd";
i.stopPattern = thisProcess.nowExecutingPath.dirname +/+ "SYSTEM/stop-pattern.scd";
i.level = thisProcess.nowExecutingPath.dirname +/+ "SYSTEM/levelIndicator.scd";


// Actions
if (g.main==nil, {i.guiFile.load;}, {"Window already open!".postln});





//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// BASIC MIDI
i.startMidi = Task({
	MIDIClient.init;
	7.wait;
	~kontrolMidi = MIDIOut.newByName("Platform M+ V1.07", "Platform M+ V1.07", 1506962642);
	MKtl.find;
	1.wait;
	~kontrol = MKtl('midi_1_platfo', "icon-platform-m-explored");
	g.systemButton[0].value_(2);
	"".postln;
	"MIDI connected".postln
}, AppClock);




//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// INTERACTION
i.interaction = Task({
	i.iconFile.load;
	"Interaction loaded ...".postln;
	g.systemButton[1].value_(2)
}, AppClock);





//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// SYSTEM BOOT
i.systemBoot = Task({
	if (s.serverRunning==false, {s.waitForBoot;});
	2.wait;

	// SAMPLES CHECK
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
	5.wait;
	"SAMPLES LOADED + ASSIGNED!".postln;


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
	0.3.wait;
	// extra loading..
	i.mastersynth.load;
	2.1.wait;
	"Synths loaded...".postln;

	0.2.wait;
	// SETUP AUDIO ENGINE
	// AUDIO BUSSES
	i.busses = {
		i.kickBus = Bus.audio(numChannels:2);
		i.beatBus = Bus.audio(numChannels:2);
		i.bassBus = Bus.audio(numChannels:2);
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
	s.plotTree;
	"SystemBoot done ...".postln;
	g.systemButton[2].value_(2);
}, AppClock);







//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// AUDIO
i.bootAudio = Task({
	// AUDIO ENGINE
	CmdPeriod.run;
	0.4.wait;

	// GROUPS:
	~synths = Group.new(addAction:\addToHead);
	~instrumentGroup = Group.new(~synths, \addAfter);
	~masterGroup = Group.new(addAction:\addToTail);
	~masterGroupOut = Group.new(addAction:\addToTail);

	// INSTRUMENT SYNTHS
	i.inst0Synth = Synth(\instSynth0, [
		\inBus, i.inst0.index, \out, i.synthBus.index, \outRev, i.revBus.index, \filterBus, b[\kn0].index,
		\ampBus, b[\sl0].index, \amp, 0.8], target: ~instrumentGroup);
	// MEL BUS
	i.inst1Synth = Synth(\instSynth1, [
		\inBus, i.inst1.index, \out, i.melBus.index, \outRev, i.revBus.index, \filterBus, b[\kn1].index,
		\ampBus, b[\sl1].index, \amp, 0.8], target: ~instrumentGroup);
	i.inst2Synth = Synth(\instSynth2, [
		\inBus, i.inst2.index, \out, i.bassBus.index, \outRev, i.revBus.index, \filterBus, b[\kn2].index,
		\ampBus, b[\sl2].index, \amp, 0.8], target: ~instrumentGroup);
	i.inst3Synth = Synth(\instSynth3, [
		\inBus, i.inst3.index, \out, i.synthBus.index, \outRev, i.revBus.index, \filterBus, b[\kn3].index,
		\ampBus, b[\sl3].index, \amp, 0.8], target: ~instrumentGroup);
	i.inst4Synth = Synth(\instSynth4, [
		\inBus, i.inst4.index, \out, i.beatBus.index, \outRev, i.revBus.index, \filterBus, b[\kn4].index,
		\ampBus, b[\sl4].index, \amp, 0.8], target: ~instrumentGroup);
	i.inst5Synth = Synth(\instSynth5, [
		\inBus, i.inst5.index, \out, i.beatBus.index, \outRev, i.revBus.index, \filterBus, b[\kn5].index,
		\ampBus, b[\sl5].index, \amp, 0.8], target: ~instrumentGroup);
	i.inst6Synth = Synth(\instSynth6, [
		\inBus, i.inst6.index, \out, i.kickBus.index, \outRev, i.revBus.index, \filterBus, b[\kn6].index,
		\ampBus, b[\sl6].index, \amp, 0.8], target: ~instrumentGroup);

	// REVERB
	i.reverb = Synth(\reverb, [
		\inBus1, i.revBus.index,
		\out, i.melBus.index,
		\inAmp, b[\sl7].index,
		\inParam, b[\kn7].index,
		\amp, 0.8, \revtime, 0.2, \mix, 0.9, \predelay, 0.4
	], target: ~instrumentGroup, addAction:\addToTail); // rev

	// MASTER SYNTH

	~outKick = Synth(\masterSynth, [\inBus, i.kickBus.index, \out, 2], target: ~masterGroup);
	~outBeat = Synth(\masterSynth, [\inBus, i.beatBus.index, \out, 4], target: ~masterGroup);
	~outBass = Synth(\masterSynth, [\inBus, i.bassBus.index, \out, 6], target: ~masterGroup);
	~outSynth = Synth(\masterSynth, [\inBus, i.synthBus.index, \out, 8], target: ~masterGroup);
	~outMel = Synth(\masterSynth, [\inBus, i.melBus.index, \out, 10], target: ~masterGroup);

	~masterOut = Synth(\masterOutSynth, [
		\inBus1, 2,
		\inBus2, 4,
		\inBus3, 6,
		\inBus4, 8,
		\inBus5, 10,

		\kickTresh, 0.3,
		\kickBelow, 1,
		\kickAbove, 0.6,
		\kickTime, 0.01,
		\kickRelease, 0.1,

		\mainTresh, 0.2,
		\mainBelow, 1,
		\mainAbove, 0.3,
		\mainTime, 0.01,
		\mainRelease, 0.1,
		\out, 0,
		\ampMul, 1.5,
		\amp, 1,
	],
	target:~masterGroupOut);

	i.compMaster = [
		{
			// without
			~masterOut.set(
				\kickTresh, 0.5,
				\kickBelow, 1,
				\kickAbove, 1,
				\kickTime, 0.01,
				\kickRelease, 0.1,

				\mainTresh, 0.5,
				\mainBelow, 1,
				\mainAbove, 1,
				\mainTime, 0.01,
				\mainRelease, 0.1,);
		},
		{
			// kicky
			~masterOut.set(
				\kickTresh, 0.3,
				\kickBelow, 1,
				\kickAbove, 0.6,
				\kickTime, 0.01,
				\kickRelease, 0.1,

				\mainTresh, 0.2,
				\mainBelow, 1,
				\mainAbove, 0.3,
				\mainTime, 0.01,
				\mainRelease, 0.1);
		},
		{
			// black hole
			~masterOut.set(
				\kickTresh, 0.6,
				\kickBelow, 1,
				\kickAbove, 0.1,
				\kickTime, 0.01,
				\kickRelease, 0.15,

				\mainTresh, 0.8,
				\mainBelow, 1,
				\mainAbove, 0.01,
				\mainTime, 0.01,
				\mainRelease, 0.1);
		},
		{
			// mod2
			~masterOut.set(
				\kickTresh, 0.3,
				\kickBelow, 1,
				\kickAbove, 0.7,
				\kickTime, 0.01,
				\kickRelease, 0.1,

				\mainTresh, 0.2,
				\mainBelow, 1,
				\mainAbove, 0.8,
				\mainTime, 0.01,
				\mainRelease, 0.1);
		},
		{
			// massive
			~masterOut.set(
				\kickTresh, 0.3,
				\kickBelow, 1,
				\kickAbove, 0.7,
				\kickTime, 0.01,
				\kickRelease, 0.1,

				\mainTresh, 0.1,
				\mainBelow, 1,
				\mainAbove, 0.2,
				\mainTime, 0.01,
				\mainRelease, 0.1);
		},
	];


	// load OSC Defs level messages
	i.level.load;
	// set Compressor in GUI
	g.masterButton[1].value_(1);

	// Load current Song
	"Load Current Song".postln;
	g.currSong.value_(0).changed(\val);

	TempoClock.default.tempo = (120/30);
	"Audio booted".postln;
	~system = true; // state that system is not running
	1.wait;
	g.systemButton[3].value_(2)
}, AppClock);




//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// STANDBY
i.standBy = Task({
	//g.systemButton[4].value_(2)
}, AppClock);




//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// REMOTE for starts with GUI
g.systemStartTasks = [
	i.startMidi,
	i.interaction,
	i.systemBoot,
	i.bootAudio,
	i.standBy,
];






// EOF
)













/*
b[\kn0].get

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// master compression settings

(
// used
~masterOut.set(
\kickTresh, 0.3,
\kickBelow, 1,
\kickAbove, 0.8,
\kickTime, 0.01,
\kickRelease, 0.1,

\mainTresh, 0.2,
\mainBelow, 1,
\mainAbove, 0.3,
\mainTime, 0.01,
\mainRelease, 0.1

\ampMul, 1.5,
);
)



(


)


(
// default
~masterOut.set(
\kickTresh, 0.1,
\kickBelow, 1,
\kickAbove, 0.5,
\kickTime, 0.01,
\kickRelease, 0.15,

\mainTresh, 0.5,
\mainBelow, 1,
\mainAbove, 0.8,
\mainTime, 0.01,
\mainRelease, 0.1

\ampMul, 1.5,
);
)



~reverb.set(
\amp, 1,
\revtime, 0.2,
\mix, 0.9,
\predelay, 0.4,
)
*/



