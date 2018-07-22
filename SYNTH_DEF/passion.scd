// Synths PASSION


(
SynthDef(\passion1, {|out=0, amp=1, xamp=0, freq=20, lf=2|  // 280, 220, 1120
	var lfo, sig, env;
	lfo = LFNoise1.kr(lf);
	sig = SinOscFB.ar([freq, freq]*(lfo.range(0.2, 6)), lfo.range(1, 3), 0.9);
	sig = sig * amp * xamp;
	Out.ar(out, sig);
}).add;


SynthDef(\passion2, {|out=0, amp=1, xamp=0, freq=20, lf=12, fb=1.6|  // 280, 220, 1120, fb=1.6/3.6
	var lfo, sig, env;
	lfo = LFNoise0.kr(lf);
	sig = Mix.ar([
			SinOscFB.ar([freq, freq], fb),
			SinOscFB.ar([freq*1.3, freq]*lfo.range(1,1.2), 1.4),
			BrownNoise.ar(lfo.range(0,0.7))
		])/3;
	sig = sig * amp * xamp;
	Out.ar(out, sig);
}).add;


)








/*
e[\in3Func1] = {
	p[\in3].quant_(1);
	p[\in3].fadeTime =1;
	p[\lfo3]= {LFNoise0.kr(12)};
	p[\in3] = {|f=20|
		Mix.ar([
			SinOscFB.ar([f, f], 1.6),
			SinOscFB.ar([f*1.3, f]*p[\lfo3].kr.range(1,1.2), 1.4),
			BrownNoise.ar(p[\lfo3].kr.range(0,0.7))
		])/3;
	};
};

e[\in3Func2] = {
	p[\in3].quant_(1);
	p[\in3].fadeTime =1;
	p[\lfo3]= {LFNoise0.kr(3)};
	p[\in3] = {|f=20|
		Mix.ar([
			SinOscFB.ar([f, f], 3.6),
			SinOscFB.ar([f*1.3, f]*p[\lfo3].kr.range(1,1.2), 1.4),
			BrownNoise.ar(p[\lfo3].kr.range(0,0.7))
		])/3;
	};
};
*/
















/*
e[\in0Func1] = {
	p[\in0Lfo] ={LFNoise1.kr(2)};
	p[\in0] = {|freq=20|
		SinOscFB.ar([freq, freq]*(p[\in0Lfo].kr.range(0.2, 6)), p[\in0Lfo].kr.range(1, 3), 0.9)
	};
};

e[\in0Func2] = {
	p[\in0Lfo] ={LFNoise1.kr(12)};
	p[\in0] = {|freq=120|
		SinOscFB.ar([freq, freq]*(p[\in0Lfo].kr.range(0.2, 6)), p[\in0Lfo].kr.range(1, 3), 0.9)
	};
};

e[\in0Func3] = {
	p[\in0Lfo] ={LFNoise1.kr(33)};
	p[\in0] = {|freq=50|
		SinOscFB.ar([freq, freq]*(p[\in0Lfo].kr.range(0.2, 6)), p[\in0Lfo].kr.range(1, 3), 0.9)
	};
};
*/












/*
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
*/