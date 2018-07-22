
///





(
SynthDef(\reverb, {
	arg in, predelay=0.4, revtime=1.8, lpf=4500, mix=0.15, amp=1, out=0;
	var dry, wet, temp, sig;
	dry = In.ar(in, 2);
	temp = In.ar(in, 2);
	wet = 0;
	temp = DelayN.ar(temp, 0.2, predelay);
	16.do{
		temp = AllpassN.ar(temp, 0.05, {Rand(0.001, 0.05)}!2, revtime);
		temp = LPF.ar(temp, lpf);
		wet = wet + temp;
	};
	sig = XFade2.ar(dry, wet, mix*2-1, amp);
	OffsetOut.ar(out, sig)
}).add
)
