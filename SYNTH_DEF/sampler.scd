
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =//
// SYNTHS
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =//

// "http://sccode.org/1-1HT"  Sampler


SynthDef(\samplerStereo, {
	|out = 0, bufnum = 0, amp = 0.9, rate = 1, t_trig = 1, startPos = 0, lp = 19000, loop=0, done=0, rel=0.6, pan=0, rev=0, hp=0|
	var sig, env;
	env = EnvGen.kr(Env.perc(0.001, rel), doneAction:0);
	sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)
		* rate, t_trig, startPos, loop:loop, doneAction:done);
	sig = LPF.ar(sig, lp) * amp * env * 0.24;
	sig = HPF.ar(sig, hp);
	sig = Pan2.ar(sig, pan);
	sig = (sig + (FreeVerb.ar(sig, 1)*rev));
	DetectSilence.ar(sig, doneAction:2);
	Out.ar(out, sig);
}).add;




SynthDef(\samplerMono, {
	|out = 0, bufnum = 0, amp = 0.9, rate = 1, t_trig = 1, startPos = 0, lp = 19000, loop=0, done=2|
	var sig, env;
	sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)
		* rate, t_trig, startPos, loop:loop, doneAction:done);
	sig = LPF.ar(sig, lp) * amp;
	sig = Pan2.ar(sig);
	Out.ar(out, sig);
}).add;



SynthDef(\samplerMonoPerc, {
	|out = 0, bufnum = 0, amp = 0.9, rate = 1, t_trig = 1, startPos = 0, lp = 19000, loop=0, done=2, pan=0, rel=0.3, rev=0|
	var sig, env, envPerc;
	envPerc = EnvGen.kr(Env.perc(0.001, rel), doneAction:0);
	sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)
		* rate, t_trig, startPos, loop:loop, doneAction:0);
	sig = LPF.ar(sig, lp) * amp;
	sig = Pan2.ar(sig, pan) * envPerc;
	sig = (sig + (FreeVerb.ar(sig, 1)*rev))/2;
	DetectSilence.ar(sig, doneAction:2);
	Out.ar(out, sig);
}).add;










/*
s.plotTree
x = Synth(\samplerMono, [\out, 0, \bufnum, ~sample[\noise].[3].bufnum, \loop, 0, \done, 0, \rate, 0.3]);
x.set(\loop, 1);
x.set(\loop, 0);
x.set(\t_trig, 1);
x.set(\bufnum, ~sample[\tiny_high].[1].bufnum)
x.free

~sample.collect.do({|i|i.postln})
~sample.[\tiny_low].[1].play
~sample.[\tiny_low].[0].postcs

~sample.[\tiny_low].dump
~sample.[\tiny_low].postcs
~sample.[\tiny_low]
~sample.[\tiny_low].[1].play
~sample.[\tiny_low].[1].query

~sample.[\tiny_low].[0].sampleRate
~sample.[\tiny_low].[0].numFrames
~sample.[\tiny_low].[0].numChannels
~sample.[\tiny_low].[0].bufnum
~sample.[\tiny_low].[0].plot
~sample.[\tiny_low].[0].duration/60 // in seconds
~sample.[\tiny_low].postln
~sample.[\tiny_low].size
*/

