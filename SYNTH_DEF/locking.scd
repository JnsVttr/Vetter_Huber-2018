// Synths feedback


(
SynthDef(\locking, {|out=0, amp=0.6, freqMul=3, freq=222, atk=1, rel=1|
	var sig, env;
	env = EnvGen.kr(Env.perc(atk, rel), doneAction:2);
	sig = SinOsc.ar([freq, freq+3]*freqMul, 0, 0.5);
	sig = sig * env * amp;
	Out.ar(out, sig);
}).add;

)

