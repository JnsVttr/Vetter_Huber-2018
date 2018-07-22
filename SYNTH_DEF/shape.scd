// SYNTH SHAPE




(
SynthDef(\shape, {
	|out=0, amp=1, freq=200, gate=1, n=3|
	var sig, env;
	sig = LFSaw.ar([freq, freq+1]) + LFNoise1.ar([freq, freq]*n);
	sig = sig *amp;

	env = EnvGen.kr(Env.adsr(), gate, doneAction:2);

	sig = sig * env;
	Out.ar(out, sig);
}).add;



SynthDef(\shapePerc, {
	|out=0, amp=1, freq=200, n=3, atk= 0.01, rel=0.5|
	var sig, env;
	sig = LFSaw.ar([freq, freq+12]) + LFNoise1.ar([freq, freq]*n);
	sig = sig *amp;

	env = EnvGen.kr(Env.perc(atk, releaseTime:rel), doneAction:2);

	sig = sig * env;
	Out.ar(out, sig);
}).add;



SynthDef(\shapePercSin, {
	|out=0, amp=1, freq=200, n=3, atk= 0.01, rel=0.5|
	var sig, env;
	sig = LFSaw.ar([freq, freq+12]) + LFNoise1.ar([freq, freq]*n, 0.4) + SinOsc.ar([freq, freq+20], 0, 0.5);
	sig = sig *amp;

	env = EnvGen.kr(Env.perc(atk, releaseTime:rel), doneAction:2);

	sig = sig * env;
	Out.ar(out, sig);
}).add;






)




/*

x = Synth(\shapePerc, [\rel, 1])

*/