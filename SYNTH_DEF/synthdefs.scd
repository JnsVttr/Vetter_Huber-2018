
(

// MasterSynth

SynthDef(\masterSynth, {|out=0, inBus=120, amp=0.97|
	var sig;
	sig = In.ar(inBus, 2);
	sig = Compander.ar(sig) * amp;
	Out.ar(out, sig)
}).add;


7.do({|c|
	SynthDef(("instSynth"++c).asSymbol, {|out=0, outRev=2, revAmp=0, inBus=120, ampBus=12, amp=0.97, hp=2200, filterBus=221|
		var sig, ampN=0.98, lpN=3000, imp, delimp;
		sig = In.ar(inBus, 2);
		sig = Compander.ar(sig);
		ampN = In.kr(ampBus, 1);
		lpN = In.kr(filterBus, 1).linexp(0, 1, 200, 20000);
		sig = LPF.ar(sig, lpN);
		sig = sig * ampN;
		// levels
		imp = Impulse.kr(10);
		    delimp = Delay1.kr(imp);

		Out.ar(out, sig);
		Out.ar(outRev, sig * revAmp);
		SendReply.kr(imp, ("/levels"++c).asSymbol, [Amplitude.kr(sig), K2A.ar(Peak.ar(sig, delimp).lag(13))]);
	}).add;
});

SynthDef(\reverb, {|out=0, inBus1=120, inAmp=12, inParam= 123, amp=0.97, predelay=0.4, revtime=1.8, lpf=4500, mix=0.15|
	var sig, sig1, rev, dry, wet, temp, ampN, paramN, imp, delimp;
	sig1 = In.ar(inBus1, 2);
	sig = Compander.ar(sig1);
	ampN = In.kr(inAmp, 1);
	paramN = In.kr(inParam, 1).linlin(0, 1, 0.1, 1.4);
	revtime = paramN;
	dry = sig;
	temp = sig;
	wet = 0;
	temp = DelayN.ar(temp, 0.2, predelay);
	16.do{
		temp = AllpassN.ar(temp, 0.05, {Rand(0.001, 0.05)}!2, revtime);
		temp = LPF.ar(temp, lpf);
		wet = wet + temp;
	};
	sig = XFade2.ar(dry, wet, mix*2-1, amp);
	sig = sig * ampN;
	// levels
	imp = Impulse.kr(20);
    delimp = Delay1.kr(imp);
	SendReply.kr(imp, ("/levels"++7).asSymbol, [Amplitude.kr(sig), K2A.ar(Peak.ar(sig, delimp).lag(3))]);
	OffsetOut.ar(out, sig)
}).add;




SynthDef(\masterOutSynth, {|out=0,
	inBus1=120, inBus2=121, inBus3=122, inBus4=123, inBus5=124,
	kickTresh=0.1, kickBelow=1, kickAbove=0.5, kickTime=0.01, kickRelease=0.15,
	mainTresh=0.5, mainBelow=1, mainAbove=0.8, mainTime=0.01, mainRelease=0.1,
	amp=0.8, ampMul=1.5|
	var sig, chan1, chan2, chan3, chan4, chan5;
	// kick
	chan1 = In.ar(inBus1, 2);
	// all other
	chan2 = In.ar(inBus2, 2);
	chan3 = In.ar(inBus3, 2);
	chan4 = In.ar(inBus4, 2);
	chan5 = In.ar(inBus5, 2);
	// sum all other
	sig = (chan2 + chan3 + chan4 + chan5) * 0.2;
	// compress all other with kick sig
	sig = Compander.ar(
		in: sig,
		control: chan1,
		thresh:kickTresh,
		slopeBelow:kickBelow,
		slopeAbove:kickAbove,
		clampTime: kickTime,
		relaxTime:kickRelease,
	);
	// add kick
	sig = sig + (chan1 * 0.25);
	// master compressor
	sig = Compander.ar(
		in: sig,
		control: sig,
		thresh:mainTresh,
		slopeBelow:mainBelow,
		slopeAbove:mainAbove,
		clampTime: mainTime,
		relaxTime:mainRelease,
	);

	// main volume
	sig = sig * ampMul * amp;
	//sig = Select.ar(CheckBadValues.ar(sig, 0, 0), [sig, sig]);
	ReplaceOut.ar(out, Limiter.ar(sig)) ;
}).add;

/*

*/





// Melodie Synth

SynthDef(\Plucking, {arg out=0, amp = 0.1, freq = 440, decay = 5, coef = 0.1, verbMix = 0.9, verbSize = 0.9, verbDamp = 0.0001, vibratoRate = 7, vibratoMul = 10, pan = 0, hp = 0;
	var env, snd, vibrato;
	env = Env.linen(0, decay, 0).kr(doneAction: 2);
	vibrato = SinOsc.kr(freq: vibratoRate, mul: freq/vibratoMul);
	snd = Pluck.ar(
		in: GrayNoise.ar(amp),
		trig: Impulse.kr(0),
		maxdelaytime: 0.1,
		delaytime: freq.reciprocal,
		decaytime: decay,
		coef: coef);
	snd = FreeVerb.ar(in: snd, mix: verbMix, room: verbSize, damp: verbDamp);
	snd = Pan2.ar(snd, pan);
	snd = HPF.ar(snd, hp);
	Out.ar(out, Splay.ar(snd, spread: 0.75, level: SinOsc.kr(freq: vibrato), center: 0));
}).add;




// Akt I Bass

SynthDef(\slow, {
	|out=0, amp=0.7, freq=100, detune=1.2, lp=1200, gate=1, fb=1.2, rel=1.2|
	var sig, env;
	env = EnvGen.kr(Env.linen(0.01, 0.2, rel, curve:-3), gate, doneAction:2);
	sig = SinOscFB.ar([freq, freq*detune], fb);
	sig = sig * env * amp;
	Out.ar(out, sig);
}).add;





// Sampler

SynthDef(\samplerStereo, {
	|out = 0, bufnum = 0, amp = 0.9, rate = 1, t_trig = 1, startPos = 0, lp = 19000, loop=0, done=2 rel=0.6|
	var sig, env;
	env = EnvGen.kr(Env.perc(0.001, rel), doneAction:2);
	sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)
		* rate, t_trig, startPos, loop:loop, doneAction:done);
	sig = LPF.ar(sig, lp) * amp * env;
	Out.ar(out, sig);
}).add;

SynthDef(\samplerMono, {
	|out = 0, bufnum = 0, amp = 0.9, rate = 1, t_trig = 1, startPos = 0, lp = 19000, loop=0, done=2|
	var sig, env;
	sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)
		* rate, t_trig, startPos, loop:loop, doneAction:done);
	sig = LPF.ar(sig, lp) * amp;
	sig = Pan2.ar(sig);
	Out.ar(out, sig);
}).add;








// Deep Synth

SynthDef.new(\iter2, {
	arg out=0, freq = 100, dev = 1.02, gate = 1, amp=0.6;
	var temp, sum, env;
	env = EnvGen.kr(
		Env.new ([0,1,0], [0.1, 1], \sin, 1),
		gate: gate,
		doneAction:2
	);
	sum = 0;
	10.do{
		arg count;
		temp = SinOsc.ar(
			freq *
			(count + 1) *
			LFNoise1.kr({Rand(0.05, 0.2)}!2).range(dev.reciprocal, dev)
		);
		temp = temp * LFNoise1.kr({Rand(0.5, 8)}!2).exprange(0.01, 1);
		sum = sum + temp;
	};
	sum = sum * 0.05 * env * amp;
	Out.ar(out, sum);
}).add;



// Gepolter

SynthDef.new(\gray, {arg out = 0, freq = 400, amp = 1, dur = 1;
	var env, src, fdbin, fdbout;
	env = EnvGen.kr(Env([0, 1, 0], [0.05, 0.95], \sin), timeScale: dur, levelScale: amp, doneAction: 2);
	src = LPF.ar(GrayNoise.ar(amp), freq, env);
	Out.ar(out, Pan2.ar(src, Rand.new(-0.7, 0.7)));
}).add;




// AKT II SinTone + Bass

SynthDef(\sin, {
	|out=0, amp=0.9, rel = 2, revMix=0.4, relNoise=0.1, ring=0|
	var sig, env, envNoise, sigPure, sigRing;
	env = EnvGen.kr(Env.perc(0.01, rel), doneAction:0);
	envNoise = EnvGen.kr(Env.perc(0.01, relNoise));
	sig = SinOsc.ar([132, 132], 0, 0.8) + Saw.ar([1040, 1046]*LFNoise2.kr(1, 0.02, 1), 0.2) + WhiteNoise.ar(0.6*envNoise);
	sigPure = sig;
	sigRing = sig + (DynKlank.ar(`[[800, 1071, 1153, TChoose.kr(Impulse.kr(0.1),[1723, 1923, 2223])], nil, [1, 1, 2, 5]], Impulse.ar(0.1)) * 0.15);
	sig = Select.ar(ring, [sigPure, sigRing]);
	sig = sig * env * 0.8;
	sig = GVerb.ar(sig, 20, drylevel:revMix) * amp;
	DetectSilence.ar(sig, doneAction:2);
	Out.ar(out, sig)
}).add;

SynthDef(\raw, {
	|out=0, amp=0.9, sus=2, rel=2, detune=1.4|
	var sig, env;
	env = EnvGen.kr(Env.linen(0.05, sus, rel));
	sig = SinOscFB.ar([50, 56]/detune * EnvGen.kr(Env.linen(1, 2, 3, 0.6, \sine)).linlin(0, 1, 0.99, 1.3), LFNoise0.kr(0.5, 0.2, 1.3).lag(1), 0.6);
	sig = sig * env * 0.5;
	sig = sig + GVerb.ar(sig, 40, damping:SinOsc.kr(0.2, 0, 0.2, 0.5), drylevel:0.2, mul:0.3);
	sig = sig * amp;
	DetectSilence.ar(sig, doneAction:2);
	Out.ar(out, sig)
}).add;



// String Detuned

SynthDef.new(\tone, {
	arg out=0, freq=40, nharm=12, detune=0.2, gate=0, pan=0, amp=1;
	var sig, env;
	env = EnvGen.kr(Env.adsr(0.05,0.1, 0.5, 3),gate);
	sig = Blip.ar(
		freq *
		LFNoise1.kr(0.2!16).bipolar(detune.neg, detune).midiratio,
		nharm
	);
	sig = sig * LFNoise1.kr(0.5!16).exprange(0.1,1);
	sig = Splay.ar(sig);
	sig = Balance2.ar(sig[0], sig[1], pan);
	sig = sig * env * amp;
	Out.ar(out, sig);
}).add;

/*
x = Synth.new(\tone, [\gate, 1]);
x.set(\freq, 40);
x.set(\freq, 30);
x.set(\nharm, 21);
x.set(\detune, 0.2);
x.set(\gate, 0);
x.free;
*/




// Simple Dark

SynthDef.new(\multi, { |out=0|
	var sig, amp, env;
	env = EnvGen.kr(
		Env.new ([0,1,0], [10, 10], [1, -1]),
		doneAction:2
	);
	amp = SinOsc.kr({ExpRand(0.2, 12)}!8).range(0,0.25);
	sig = SinOsc.ar({ExpRand(50, 1200)}!8);
	sig = sig * amp * env;
	sig = Splay.ar(sig) * 0.9;
	Out.ar(out, sig);
}).add;



// Weired Kick

SynthDef(\kik, { |out=0, preamp = 1, amp = 1, lp=1200, hFreq=500, rel=0.8, fRel=0.5|
    var    freq = EnvGen.kr(Env([hFreq, 36], [fRel], -4)),
	sig = (SinOsc.ar(freq, 0.5pi, preamp).distort + WhiteNoise.ar(freq/hFreq) * amp )
            * EnvGen.kr(Env([0, 1, 0.8, 0], [0.01, 0.1, rel]), doneAction: 2);
	sig = LPF.ar(sig, lp);
    Out.ar(out, sig ! 2);
}).add;


// Tasch Sound

SynthDef(\schaff, {
	|out=0, amp=0.6, rel=1, lp=6000, speed=12|
	var sig, env, freq;
	env = EnvGen.kr(Env.perc(0.01, rel), doneAction:2);
	freq = LFNoise0.kr([speed, speed*1.3], 0.4, 0.5).lag(0.3);
	sig = PinkNoise.ar(freq) + WhiteNoise.ar(freq);
	sig = LPF.ar(sig, lp);
	sig = sig * env * amp/2;
	Out.ar(out, sig);
}).add;



// Metall Sound

SynthDef(\schwing, {
	|out=0, amp=0.6, rel=1, lp=6000|
	var sig, env, freq;
	env = EnvGen.kr(Env.perc(0.01, rel), doneAction:2);
	freq = LFNoise0.kr([24, 32], 0.4, 0.5).lag(0.3);
	sig = PinkNoise.ar(freq) + WhiteNoise.ar(freq);
	sig = LPF.ar(sig, lp);
	sig = sig * env * amp/2;
	Out.ar(out, sig);
}).add;
//x = Synth(\schwing);





// Atonal

SynthDef(\atmo, {|out=0, gate=1, lagTime=1, fb=0.1, amp=0.3|
	var main, sig, env;
	env = EnvGen.kr(Env.adsr(0.2, 1, 1), gate, doneAction:2);
	sig = SinOscFB.ar(
		Array.fill(6, { arg i; 70+(i * 410) })
		* LFNoise0.kr(Array.fill(6, { arg i; 0.18 + (i * 0.1)}), 0.13, 1.1).lag(lagTime),
		Array.fill(6, { arg i; 0.9-(i * 0.1) })*fb,
		Array.fill(6, { rrand(0.1, 0.4) })*amp
	);
	sig = Mix.ar([ [sig[0], sig[2]], [sig[1], sig[3]], [sig[4], sig[5]]]);
	main = FreeVerb.ar(sig, mix:0.8, room:0.2, damp:0.8, mul:1);
	main = main * env;
	Out.ar(out, main);
}).add;


/*
x = Synth(\atmo, [\amp, 0.6])
x.set(\lagTime, 0.9)
x.set(\amp, 0.5)
x.set(\fb, 0.7)
x.set(\gate, 0)
*/




)





