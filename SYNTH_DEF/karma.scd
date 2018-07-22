// Synths KARMA


(

SynthDef(\loc, {|out=0, amp=0.6, freqMul=3, freq=222|
	var sig, env;
	env = EnvGen.kr(Env.perc(0.01, 1), doneAction:2);
	sig = SinOsc.ar([freq, freq+3]*freqMul, 0, 0.5);
	sig = sig * env * amp;
	Out.ar(out, sig);
}).add;

SynthDef(\locWide, {|out=0, amp=0.6, freqMul=1, rel=0.4|
	var sig, env;
	env = EnvGen.kr(Env.perc(0.01, rel), doneAction:2);
	sig = Blip.ar(Saw.kr([21, 33], 220, 1400)*freqMul, 122, LFNoise0.kr(1, 0.2, 0.22));
	sig = sig * env * amp * 1;
	Out.ar(out, sig);
}).add;

SynthDef(\ka, {|out=0, amp=0.6, freqMul=0.25, rel=0.4, fb=1, lp=3000, hp=0|
	var sig, env;
	env = EnvGen.kr(Env.perc(0.01, rel), doneAction:2);
	sig = SinOscFB.ar([222, 224]*freqMul * SinOsc.kr(0.1, 0, 0.2, 1), fb + Saw.kr(0.4, 1, 0.2));
	sig = sig * env * amp;
	sig = LPF.ar(sig, lp);
	sig = HPF.ar(sig, hp);
	Out.ar(out, sig);
}).add;

SynthDef(\bow, {|out=0, amp=0.6, freqMul=0.25, rel=0.4|
	var sig, env;
	env = EnvGen.kr(Env.perc(0.01, rel), doneAction:2);
	sig = DynKlang.ar(`[
		        [280, 900, 2800] + SinOsc.kr([1, 7, 4.2], 0, [13, 74, 12]),
		        [0.3, 0.3, 0.3] * Saw.kr(2, 0.2, 1),
		        [pi,pi,pi] * Saw.kr(1, 0.2, 1)
    ]);
	sig = Pan2.ar(sig, LFNoise1.kr(2, 0.5, 0.5));
	sig = sig * env * amp;
	Out.ar(out, sig);
}).add;

SynthDef(\shock, {|out=0, amp=0.6, freq=200, rel=0.4, pan=0, gray=0.01|
	var sig, env;
	env = EnvGen.kr(Env.perc(0.01, rel), doneAction:2);
	sig = Klank.ar(`[[60, 91, freq, freq], nil, [1, 1, 1, 1]], Impulse.ar(0.2)) + GrayNoise.ar(gray);
	sig = sig * env * amp * 0.5;
	sig = Pan2.ar(sig, pan);
	Out.ar(out, sig);
}).add;

SynthDef(\shockKlank, { arg out=0, freq=300, atk=0.01, rel=0.8, amp=0.6;
    var klank, n, harm, kAmp, ring, env;
	env = EnvGen.kr(Env.perc(atk, rel), doneAction:2);
    // harmonics
    harm = \harm.ir(Array.series(4, 1, 1));
    // amplitudes
    kAmp = \kAmp.ir(Array.fill(4, 0.3));
    // ring times
    ring = \ring.ir(Array.fill(4, 1));
    klank = Klank.ar(`[harm, kAmp, ring], {ClipNoise.ar(0.003)}.dup, freq);
	klank = klank * env * amp * 4;
    Out.ar(out, klank);
}).add;


)

