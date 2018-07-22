////////////////////////////////  GRAIN SAMPLER

(
SynthDef(\grain, {
	|out = 0, bufnum = 0, rate=1, startPos = 0, room=11
	rel= 1, amp=1, rev = 1, freq =9000|
	var sig, env, silence, env2;

	env = EnvGen.kr(Env.perc(0.1, rel));
	sig = BufRd.ar(1, bufnum,
		Phasor.ar(0,
			BufRateScale.kr(bufnum)*rate,
			startPos,
			BufFrames.kr(bufnum)),
			0);
	//sig = Pan2.ar(sig*amp);
	sig = GVerb.ar(sig, room, rev, drylevel:1);
	sig = LPF.ar(sig, freq);
	env2 = EnvGen.kr(
		Env.new([0, 1, 0], [0.01, rel ], \sin), doneAction:2);
	sig = sig * env2 * amp;
	Out.ar(out, sig);
}).add
);



(
SynthDef(\grain2, {
	|out = 0, bufnum = 0, rate=1, startPos = 0, room=21
	rel= 1, amp=1, rev = 1, freq =12000|
	var sig, env, silence, env2;

	env = EnvGen.kr(Env.perc(0.1, rel));
	sig = BufRd.ar(2, bufnum,
		Phasor.ar(0,
			BufRateScale.kr(bufnum)*rate,
			startPos,
			BufFrames.kr(bufnum)),
			0);
	//sig = Pan2.ar(sig*amp);
	//sig = GVerb.ar(sig, room, rev, drylevel:1);
	sig = LPF.ar(sig, freq);
	env2 = EnvGen.kr(
		Env.new([0, 1, 0], [0.01, rel ], \sin), doneAction:2);
	sig = sig * env2 * amp;
	Out.ar(out, sig*amp);
}).add
)








/*

~japan = Buffer.read(s, ("/Users/Linz/Documents/SuperCollider/LIVE_SET/SAMPLES/AUDIO/japan.wav"))

~japan.query

x = Synth(\grain, [\out, 0, \bufnum, a[\special][0].bufnum, \rel, 2])
x = Synth(\grain, [\out, 2, \bufnum, ~bass[19].bufnum])




Pdef(\Japan).play.quant_(8)
Pdef(\Japan).stop

~japanGrain.value

(
~japanGrain = {Pdef(\Japan, Pbind(\instrument, \grain,
	\out, 2,
	\dur, Pseq([4, 1, 1, 1, 1, 1, 0.1, 1.9]/6, inf),
	\bufnum, ~japan.bufnum,
	//\startPos, Pwhite(0, ~sounds[0].numFrames.postln, inf),
	\startPos, Pseq([150000, 140000, 243020, 308220].scramble, inf),
	\rel, Pseq([0.9, 0.2, 0.3, 0.4]*0.9, inf),
	\rate, Pseq([1, 1, 0.5, 0.9], inf),
	\amp, Pseq([1, 1, 0.4, 0, 1, 0.5, 0.3, 0]*1.8, inf),
	\rev, Pwhite(0.1, 9, inf),
	\freq, Pseq([2000, 10000, 2300, 1000].scramble, inf),
	\freq, 7999,
));
Pdef(\Japan).reset}
)








(
Pdef(\L, Pbind(\instrument, \grain,
	\dur, Pseq([4, 1, 1, 1, 1, 1, 0.1, 1.9]/4, inf),
	\bufnum, ~japan.bufnum,
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



*/
