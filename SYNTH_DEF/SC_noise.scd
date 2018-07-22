

// Noise for moves,


(
SynthDef(\noise, {
	|out=0, amp=1, time=1, lp = 1000, level=0.5, hp=30|
	var sig, env, env2;
	sig = BrownNoise.ar(level) + WhiteNoise.ar(level) + SinOscFB.ar(Rand(100, 110)/1.99, 1.1).dup;
	env = EnvGen.kr(Env([0,1, 0], [time, 0.05], 7), doneAction:2);
	sig = sig * env * amp;
	sig = HPF.ar(sig, hp);
	sig = LPF.ar(sig, lp);
	Out.ar(out, sig*env);
}).add
)


/*
x = Synth(\noise, [\time, 0.3, \lp, 4000])
*/



/*
(
Pdef(\nn2, Pbind(\instrument, \noise,
	\out, 333,
	\dur, 0.5,
	\time, 0.5,
	\lp, 14000,
	\hp, Pwhite(2000, 12000, inf),
	\level, 0.8,
	\amp, 0.1,
))
)

Pdef(\nn2).reset.quant_([4, 0.25])
Pdef(\nn2).play
Pdef(\nn2).stop

*/
