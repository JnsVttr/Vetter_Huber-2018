
// BASS + STRING




(
SynthDef(\Bass, {
	|out = 0, amp = 0.9, fb=2.3, pan = 0.3, hp = 2000, freq = 200, rel = 0.2|
	var sig, env;
	env = Env.perc(0.01, rel);
	sig = Pulse.ar([freq, freq-10], mul:amp)
		+ Saw.ar([freq, freq-10], amp)
		+ SinOscFB.ar([freq, freq+13]*2, fb, amp/1.1);
	sig = LPF.ar(sig, hp);
	sig = sig * EnvGen.kr(env, doneAction:2);
	sig = Pan2.ar(Mix.ar(sig), pan);
	Out.ar(out, sig);
}).add;

SynthDef(\string, {
	|out=0, amp=0.7, pan=0, freq=200, atk=0.1, rel=1|
	var env, sig;
	env = EnvGen.kr(Env.perc(atk, rel), doneAction:2);
	//sig = SinOsc.ar(freq);
	sig = Mix.ar(10.do{SinOsc.ar(rrand(freq, freq+100))});
	sig = sig * env;
	sig = Pan2.ar(sig, pan);
	Out.ar(out, sig);
}).add;
)