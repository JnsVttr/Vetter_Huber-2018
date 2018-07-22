
// Sampler Drums STEREO/ MONO to STEREO


(
SynthDef(\samplerMono, {
	|out = 0, bufnum = 0, amp = 0.9,
	rate = 1, t_trigger = 1, startPos = 0|
	var sig, env;
	env = EnvGen.kr(Env.perc(0.01,
		(BufRateScale.kr(bufnum)*rate)), doneAction:2);
	sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)
	 	* rate, t_trigger, startPos, loop:0, doneAction:2);
	sig = Pan2.ar(sig) * amp;
	Out.ar(out, sig);
}).add;

SynthDef(\samplerStereo, {
	|out = 0, bufnum = 0, amp = 0.9,
	rate = 1, t_trigger = 1, startPos = 0, lp = 9000|
	var sig, env;
	env = EnvGen.kr(Env.perc(0.01,
		(BufRateScale.kr(bufnum)*rate)), doneAction:2);
	sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)
		* rate, t_trigger, startPos, loop:0, doneAction:2);
	sig = LPF.ar(sig, lp) * amp;
	sig = Mix.ar(sig);
	Out.ar(out, sig);
}).add;


SynthDef(\samplerStereo2, {
	|out = 0, bufnum = 0, amp = 0.9,
	rate = 1, trigger = 1, startPos = 0, lp = 9000|
	var sig, env;
	env = EnvGen.kr(Env.perc(0.01,
		(BufRateScale.kr(bufnum)*rate)), doneAction:2);
	sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)
		* rate, trigger, startPos, loop:0, doneAction:2);
	sig = LPF.ar(sig, lp) * amp;
	//sig = Mix.ar(sig);
	Out.ar(out, sig);
}).add;

SynthDef(\samplerStereo2Env, {
	|out = 0, bufnum = 0, amp = 0.9,
	rate = 1, trigger = 1, startPos = 0, lp = 9000,
	atk = 0.01, rel=0.2|
	var sig, env, envPerc;
	envPerc = EnvGen.kr(Env.perc(atk, rel), doneAction:2);
	env = EnvGen.kr(Env.perc(0.01,
		(BufRateScale.kr(bufnum)*rate)), doneAction:2);
	sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)
		* rate, trigger, startPos, loop:0, doneAction:2);
	sig = LPF.ar(sig, lp) * amp * envPerc;
	//sig = Mix.ar(sig);
	Out.ar(out, sig);
}).add;

)







/*
x = Synth(\samplerStereo, [\out, 2, \bufnum, ~kick[10].bufnum])
x = Synth(\samplerStereo2, [\out, 0, \bufnum, ~special[2].bufnum])

~japan = Buffer.read(s, ("/Users/Linz/Documents/SuperCollider/LIVE_SET/SAMPLES/AUDIO/japan.wav"))

~japan.query


////////////////////////////////  GRAIN SAMPLER





(
SynthDef(\grain, {
	|out = 0, bufnum = 0, rate=1, startPos = 0,
	rel= 1, amp=1, rev = 2, freq =5000|
	var sig, env, silence, env2;

	env = EnvGen.kr(Env.perc(0.1, rel));
	sig = BufRd.ar(1, bufnum,
		Phasor.ar(0,
			BufRateScale.kr(bufnum)*rate,
			startPos,
			BufFrames.kr(bufnum)),
			0);
	//sig = Pan2.ar(sig*amp);
	sig = GVerb.ar(sig, 11, rev);
	sig = LPF.ar(sig, freq);
	env2 = EnvGen.kr(
		Env.new([0, 1, 0], [0.01, rel ], \sin), doneAction:2);
	sig = sig * env2;
	Out.ar(out, sig);
}).add
)


~japan = Buffer.read(s, ("/Users/Linz/Documents/SuperCollider/LIVE_SET/SAMPLES/AUDIO/japan.wav"))

~japan.query

x = Synth(\grain, [\out, 2, \bufnum, ~japan.bufnum])




Pdef(\L).play.quant_(8)
Pdef(\L).stop

(
Pdef(\L, Pbind(\instrument, \grain,
	\dur, Pseq([4, 1, 1, 1, 1, 1, 0.1, 1.9]/4, inf),
	\bufnum, ~kick[1].bufnum,
	//\startPos, Pwhite(0, ~sounds[0].numFrames.postln, inf),
	\startPos, Pseq([50000, 140000, 243020, 308220].scramble, inf),
	\rel, Pseq([0.9, 0.2, 0.3, 0.4]*0.9, inf),
	\rate, Pseq([1, 1, 0.5, 0.9], inf),
	\amp, Pseq([1, 1, 0.4, 0, 1, 0.5, 0.3, 0]*1.8, inf),
	\rev, Pwhite(0.1, 9, inf),
	\freq, Pseq([2000, 10000, 2300, 1000].scramble, inf),
	\freq, 7999,
));
Pdef(\L).reset
)























~sample.[\kick].play
~sample.[\special].[0].postcs

~sample.[\special].dump
~sample.[\samples].postcs
~sample.[\samples]
~sample.[\samples].[1].play
~sample.[\samples].[1].query

~sample.[\samples].[0].sampleRate
~sample.[\samples].[0].numFrames
~sample.[\samples].[0].numChannels
~sample.[\samples].[0].bufnum
~sample.[\samples].[0].plot
~sample.[\samples].[0].duration/60 // in seconds
~sample.[\samples].postln
~sample.[\samples].size




*/



