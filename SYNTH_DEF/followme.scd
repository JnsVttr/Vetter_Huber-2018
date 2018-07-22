// Synths FOLLOW ME


(
SynthDef(\bass, {|out=0, amp=0.4, freq=120, rel=0.3, fb=1, lp=120, mix=0|
	var sig, env;
	env = EnvGen.kr(Env.perc(0.01, rel), doneAction:2);
	sig = SinOscFB.ar(freq!2, fb, mul:0.9) + Saw.ar(freq!2, mul:0.6);
	sig = LPF.ar(sig, lp) * amp * env;
	sig = FreeVerb.ar(sig, mix);
	Out.ar(out, sig)
}).add;

SynthDef(\schon, {
	arg out=0, freq=53, amp=0.9, move=0.1, moveFreq=12, noiseAmp=0.2, mainAmp=0.2, atk=0.01, rel=1, bp=500;
	var sig, env, add1=30, add2=120, mod, noise, noiseEnv, lin;
	mod = LFNoise2.kr(moveFreq, move, 1);
	freq = freq * mod;
	lin = Line.kr(0, 1, 1);
	env = EnvGen.kr(Env.perc(atk, rel), doneAction:2);
	sig = (SinOsc.ar([freq, freq+freq/20], 0)
		+ SinOsc.ar([freq, (freq+freq/20)]+add1, 0)
		+ SinOsc.ar([freq, (freq+freq/20)]+add2, 0) )
	* amp * lin;


	noiseEnv = EnvGen.kr(Env.asr(6));
	noise = Gendy2.ar(0.2, 1.3, minfreq:20, maxfreq:120, mul:noiseAmp) * noiseEnv;

	sig = sig + noise;
	sig = sig * env * mainAmp;
	sig = BPF.ar(sig, bp);
	Out.ar(out, sig);
}).add;
//w.free;


/*
w = Synth(\schon, [\out, ~synthBus.index, \freq, 800, \rel, 2, \move, 0.1, \moveFreq, 41.2, \bp, 5000, \amp, 2]);
w.set(\freq, 323);
w.set(\moveFreq, 32);
w.set(\move, 0.1);
w.set(\amp, 0.4);
w.set(\noiseAmp, 0.3);
w.free;
*/

)

