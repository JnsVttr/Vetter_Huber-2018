

////////////  KICK 2  ////////////////



(
SynthDef(\kick2, {
	|out=0, amp=1, rel=0.2, freq=80|
	var subosc, subenv, suboutput, clickosc, clickenv, clickoutput, sig;

	subosc = {SinOsc.ar(freq)};
	subenv = {Line.ar(1, 0, rel, doneAction: 2)};

	clickosc = {LPF.ar(WhiteNoise.ar(1),1200)};
	clickenv = {Line.ar(0.4, 0.03, 0.01)};

	suboutput = (subosc * subenv);
	clickoutput = (clickosc * clickenv);
	sig = suboutput + clickoutput;
	Out.ar(out, Pan2.ar(sig*amp))

}).add
);


