
//////////////////   LEGATO - Schräg /////////////////


(
	SynthDef(\legato, {
		|out=0, gate = 1, freq= 800, amp = 0.3|
		var sig, env;
		env = EnvGen.kr(Env.adsr(0.1, 0.3, 0.2, 0.2, curve:\sin), gate, doneAction:2);
		sig = SinOscFB.ar([freq, freq], 0.5) * env * amp;
		//sig = GVerb.ar(sig, 20, 10)*0.2;
		sig = HPF.ar(sig, 100);
		Out.ar(out, sig);
	}).add;
)





/*


x = Synth(\legato)
x.set(\gate, 0)

(
	Pdef(\legatoSynth, Pbind(
		\instrument, \legato,
		\dur, Pseq(
			[0.25, 0.5, 0.25, 0.125, 0.125/2, 0.4625].normalizeSum.postln,
			inf)*2,
		\amp, 0.4,
		\freq, Pseq([
			Pseq([Prand([91, 93])], 1),
			Pser([87, 87], 2),
			82, 78, 82
		].midicps, inf)/2,
		\legato, Pkey(\dur)/1,
	)).reset;
)
Pdef(\legatoSynth).play
Pdef(\legatoSynth).stop



*/

