
// SC HH as Noise MONO CHAN 2



(
SynthDef(\hh1, {
	|out = 0, amp = 0.9, pan = 0.3, hp = 2000, rel=1|
	var sig, env;
	env = Env.perc(0.01, rel);
	sig = BrownNoise.ar(amp) + PinkNoise.ar(amp) + WhiteNoise.ar(amp/3);
	//sig = Pan2.ar(sig, Rand(0-pan, pan));
	sig = HPF.ar(sig, hp);
	sig = LPF.ar(sig, 10012310000);
	sig = sig * EnvGen.kr(env, doneAction:2);
	Out.ar(out, Pan2.ar(sig, pan));
}).add
)

/*
x = Synth(\hh1, [\out, 3])
*/


