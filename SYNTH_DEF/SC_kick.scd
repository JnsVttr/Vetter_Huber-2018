

// SuperCollider Kick MONO CHAN 1


// SIMPLE KICK
(
SynthDef("kick", {
	arg out=0, amp=0.9, bd=0.9, lp=100;
	var env0, env1, env1m, sig;

	env0 =  EnvGen.ar(
		Env.new([0.5, 1, 0.5, 0],
		[0.004, 0.04, 0.26],
		[-4, -2, -4]),
		doneAction:2);
	env1 = EnvGen.ar(
		Env.new([110, 59, 29],
		[0.003, 0.29], [-4, -5]));
	env1m = env1.midicps;

	sig = LFPulse.ar(env1m, 0, 0.5, 1, -0.5);
	sig = sig + WhiteNoise.ar(1);
	sig = LPF.ar(sig, lp, env0);
	sig = sig + SinOsc.ar(env1m*bd, 0, env0);

	sig = sig * 1.9 * amp;
	sig = sig.clip2(1);
	sig = Pan2.ar(sig);

	Out.ar(out, sig);
}).add;


SynthDef("kickDesert", {
	arg out=0, amp=0.9, bd=0.9, lp=100;
	var env0, env1, env1m, sig;

	env0 =  EnvGen.ar(
		Env.new([0.8, 1, 0.5, 0],
		[0.004, 0.04, 0.26],
		[-4, -2, -4]),
		doneAction:2);
	env1 = EnvGen.ar(
		Env.new([110, 59, 29],
		[0.003, 0.29], [-4, -5]));
	env1m = env1.midicps;

	sig = LFPulse.ar(env1m, 0, 0.5, 1, -0.5);
	sig = sig + WhiteNoise.ar(1);
	sig = LPF.ar(sig, lp, env0);
	sig = sig + SinOsc.ar(env1m*bd, 0, env0);

	sig = sig * 1.9 * amp;
	sig = sig.clip2(1);
	sig = Pan2.ar(sig);

	Out.ar(out, sig);
}).add;

)




/*
y = Synth(\kickDesert, [\out, i.inst6.index, \bd, 0.9])
*/





/*


(
Pdef(\kick, Pbind(
	\instrument, \kick,
	\out, 2,
	\dur, Pseq([1, Pwrand(
		[1, Pn(0.5, 2)],
		[0.8, 0.2], inf),
		1, 1, 1, 1, 1, 1, 0.8, 0.2]*0.5,
		inf),
	\amp, Pxrand([1, 1, 1, 1, 1, 0.9], inf))
).play.quant(4);
)

(
Pdef(\kick, Pbind(
	\instrument, \kick,
	\out, 2,
	\dur, Pseq(
  	  [1, 1, 1, 1, 1, 1, 1, 1, 1]*0.5, inf),
	\amp, Pxrand([1, 1, 1, 1, 1, 0.9], inf))
).reset.quant(4);
)


(
Pdef(\kick, Pbind(
	\instrument, \kick,
	\out, 2,
	\dur, Pseq([1]*0.5, inf),
	\amp, Pseq([1, 0, 1, 0], inf),
)).reset.quant_([4])
)



Pdef(\kick).stop;
Pdef(\kick).play




*/



