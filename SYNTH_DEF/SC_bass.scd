

// SC Bass STEREO Chan 3+4





(
SynthDef(\SC_bass, {
	|out = 0, amp = 0.9, fb=2.3, pan = 0.3, hp = 2000, freq = 200, rel = 0.2|
	var sig, env;
	env = Env.perc(0.01, rel);
	sig = Pulse.ar([freq, freq-10], mul:amp) 
		+ Saw.ar([freq, freq-10], amp) 
		+ SinOscFB.ar([freq, freq+13]*2, fb, amp/1.1);
	sig = Pan2.ar(sig, Rand(0-pan, pan));
	sig = LPF.ar(sig, hp);
	sig = sig * EnvGen.kr(env, doneAction:2);
	Out.ar(out, sig);
}).add
)

/*
e = Synth(\SC_bass, [\freq, 150, \out, 0])
*/


