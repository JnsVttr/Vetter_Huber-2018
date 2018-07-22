

//  Sine


(
SynthDef(\sineTone, {
	|out=0, amp = 0.5, freq = 200, gate = 1, note = 3, spin = 1, rel=1, lp=2000|
	var sig, env;

	env = EnvGen.kr(Env(
		[0, 1, 0],
		[0.01, rel], \sin),
		gate, doneAction:2);

	sig = Pulse.ar([freq, freq+note] + SinOsc.kr(spin, 0, 20, 25), 0.3);
	sig = sig * amp;
	sig = LPF.ar(sig, lp);
	//sig = GVerb.ar(sig, 10, 3);
	Out.ar(out, Pan2.ar(sig*env))
}).add;


SynthDef(\trigger,
	{Done.kr(Line.kr(doneAction:2))}
).add;
)






/*

p = Synth(\sineTone, [\freq, 1000])
p.free
p.set(\amp, 0.1, \spin, 9)


Pdef(\sineAll).stop
Pdef(\sineAll).play.quant_(4)

(Pdef(\sineAll, Pbind(\instrument, \sineTone,
	\dur, Pwrand([0.125,Pn(0.25, 2)], [0.8, 0.2], inf)*1,
	\rel, Pkey(\dur),
	\freq, Pxrand([
		Pser([600], 32),
		Pser([800], 32),
		Pser([1200], 64),
		Pser([1000], 32),
		Pser([700], 64)
	]/2.3, inf),
	\amp, Pwrand([Pwhite(0.01, 0.6, inf), 0], [0.7, 0.3], inf)/7,
	\spin, Pexprand(2, 12, inf),
	\note, Pseq([7, 10, 3, 20, 12, 11, 4, 120], inf),
)).reset.quant_(8))


*/
