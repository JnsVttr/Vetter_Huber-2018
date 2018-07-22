

//



(
SynthDef(\done, {
	|out=0, freq=150, rel=0.9, amp= 0.9, pan=0, vib=3.2, ff=6800, fg=1|
	var sig, env, noise;
	env = EnvGen.kr(Env.perc(0.001, rel), doneAction:2);
	//sig = SinOsc.ar(400, 0, 0.9);
	sig = Mix.ar([
		SinOsc.ar(freq + 20),
		SinOsc.ar(freq + 40),
		SinOsc.ar(freq + 60),
	]) *0.4;
	sig = Mix.ar(Array.fill(20, {
		|count|
		var harm;
		harm = count + 1 *freq;
		SinOscFB.ar(harm,
			feedback: 0,
			mul: max([0, 0], SinOsc.kr(count+1/vib))
		) * 1/(count+1) + BrownNoise.ar(count+1/3000);
	}));
	noise = WhiteNoise.ar(Rand(0.01, 0.04)) * EnvGen.kr(Env.perc(0.001, Rand(0.01, 0.2)));
	sig = sig + noise;
	sig = MoogFF.ar(sig, ff, fg);
	sig = sig * 0.9;
	sig = sig.distort * amp;
	sig = sig * env;
	Out.ar(out, Pan2.ar(sig, pan));
}).store;
)

