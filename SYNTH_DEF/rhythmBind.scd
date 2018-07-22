
//////////////  SIMPLE RHYTHM  ////////////////////




SynthDef(\noiseRhythm, {
	|out = 0, amp = 0.5, rel=1, pan=0, freq=10000|
	var sig, env;
	env = Env.perc(0.01, rel);
	sig = BrownNoise.ar(amp);
	sig = Pan2.ar(sig, pan);
	sig = MoogFF.ar(sig, freq);
	sig = sig * EnvGen.kr(env, doneAction:2);
	Out.ar(out, sig);
}).add




/*
x = Synth(\noiseRhythm)



(
	Pdef(\noiseRhythm, Pbind(
		\instrument, \noiseRhythm,
		\dur, Pseq([1, 1, 2, 1]/10, inf),
	).reset;
)
)


Pdef(\noiseRhythm).play.quant_(4)

*/




