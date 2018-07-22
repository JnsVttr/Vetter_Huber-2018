// Synths Desert Sun


(
SynthDef(\desert, {|out=0, amp=1, xamp=0, f=180|  // 280, 220, 1120
	var lfo, sig, env;
	lfo = LFNoise1.kr(1.5);
	sig = Mix.ar([
		SinOscFB.ar([f, f], 1.6),
		SinOscFB.ar([f*1.3, f]*lfo.range(1,1.2), 1.4),
		BrownNoise.ar(lfo.range(0,0.7))
	])/3;
	sig = sig * amp * xamp;
	Out.ar(out, sig);
}).add;


SynthDef(\desertGendy, {|out=0, amp=1, xamp=0|  // 280, 220, 1120
	var lfo, sig, env;
	lfo = LFNoise0.kr(2);
	sig = Impulse.ar([2, 3])*1.9
		+ Gendy2.ar(ampdist:1,durdist:8,minfreq:300, mul:lfo.range(0.1, 1.2))
		+ PinkNoise.ar(lfo.range(0.1, 0.99));
	sig = sig * amp * xamp;
	Out.ar(out, sig);
}).add;

)

