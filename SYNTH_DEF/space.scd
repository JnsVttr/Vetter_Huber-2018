
///////////////////// NICE SOUND SPACE ////////////////



(
	SynthDef(\space,{
		arg out=0, freq=440, sustain=0.04, fb = 0, amp=0.9, shift=255, rel=1.2;
		var env, sig;

		env = EnvGen.kr(Env.perc(0.01, sustain, rel), doneAction:2);
		sig = SinOscFB.ar([freq, freq+shift], fb, env) * amp;
		sig = LPF.ar(sig, 7000);
		Out.ar(out, sig*amp)
	}).store;
)





/*


(
	Pdef(\space1, Pbind(\instrument,
		\space,
		\dur, 0.125,
		\freq, Pbrown(0.0, 1.0, 0.1, inf)*100 +70,
		\fb, Pwhite(0, 1.2, inf),
		\amp, Pseq([1, 0.4, 0.4, 1, 1, 0, 1, 0.8].scramble, inf)*0.8,
		\shift, Pseq([132, 25, 45, 55, 5, 5, 5, 40], inf)))
	)


	Pdef(\space1).play(quant:[4, 0])
	Pdef(\space1).quant_([4, 0]).reset
	Pdef(\space1).stop




	Pdef(\space2, Pbind(
		\instrument, \space,
		\dur, 0.125,
		\freq, Pbrown(0.0, 1.0, 0.1, inf)*800 + 1450,
		\fb, Pwhite(0, 2.2, inf),
		\amp, Pseq([1, 1, 1, 0.2, 0, 0, 1, 0.8].scramble/3, inf))
	)



	Pdef(\space2).play.quant_(4)
	Pdef(\space2).stop

	*/


