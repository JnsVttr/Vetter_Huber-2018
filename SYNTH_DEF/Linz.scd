
// LINZ bass


(
SynthDef(\linz, {
	arg out=0, amp=1, freq=100, ffreq=120, bfreq=900, rel=1, wn=0.03, pos=0, ds=1, filterFreq=5200;
	var sig = Formant.ar([freq, freq], ffreq, bfreq)
	+ SinOscFB.ar([freq, freq]*2, ds, amp*2.9)
	+ WhiteNoise.ar(wn);
	var env = EnvGen.kr(Env.perc(0.01, releaseTime:rel), doneAction:2);
	sig = RLPF.ar(sig, filterFreq);
	sig = HPF.ar(sig, 140);
	Out.ar(out, Pan2.ar(Mix.ar(sig), pos) * env * amp)
}).add;
)
