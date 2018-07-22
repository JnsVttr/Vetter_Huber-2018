///// QUIETSCH /////////////

(
	SynthDef(\quietsch, {
		|out=0, amp = 1, freq = 2200, rel=1|
		var sig, env, env1, env2;

		env2 = EnvGen.kr(Env.perc(releaseTime:rel), doneAction:2);
		env = EnvGen.kr(Env([0, 1, 0], [0.08, 0.2], -4));
		env1 = EnvGen.kr(Env([0, 1300], [0.1]));
		sig = SinOsc.ar([freq, freq+432])
		+ Saw.ar([freq + env1, freq + env1]*0.3)
		+ WhiteNoise.ar(0.8) * env;

		sig = LPF.ar(sig, 4000);
		sig = HPF.ar(sig, 100);

		sig = GVerb.ar(sig, 2) * env2 * amp;
		Out.ar(out, sig);
	}).add
)



/*

x = Synth(\quietsch)

Pdef(\quietsch).play(quant:[4, 3.75])
Pdef(\quietsch).stop

(
	Pdef(\quietsch, Pbind(\instrument, \quietsch,
		\dur, 4,
		\freq, Pwhite(2000, 3300, inf),
		\amp, 0.4)).reset


	)

Pdef.all.stop

	*/


