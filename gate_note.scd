s.boot
Server.killAll

// ADSRエンベロープ を使う回
// https://note.com/sc3/n/n2ea64f656502

(
SynthDef("synth1", {
	arg freq=440, gate=1;
	var sig, env;
	env = EnvGen.kr(Env.adsr, gate, doneAction:2);
	sig = Saw.ar(freq, 0.3)!2;
	Out.ar(0, sig * env)
}).add;
)

(
SynthDef("synth2", {
	arg freq=440, gate=1;
	var sig, env;
	env = EnvGen.kr(Env.adsr(0.01, 0.3, 0.5, 2), gate, doneAction:2);
	sig = SinOsc.ar(freq, 0, 0.3)!2;
	Out.ar(0, sig * env)
}).add;
)

(
SynthDef("synth3", {
	arg freq=440, gate=1;
	var sig, env;
	env = EnvGen.kr(Env.adsr(0.01, 0.6, 0.5, 0.2), gate, doneAction:2);
	sig = Pulse.ar(freq, 0.3)!2;
	Out.ar(0, sig * env)
}).add;
)

// 45 の隣の `\` は休符
(
Pbind(
	\instrument, "synth1",
	\freq, Pseq([45, \], inf),
	\dur, 1,
).play(TempoClock.new(100/60));
)

(
Pbind(
	\instrument, "synth3",
	\midinote, Pseq([
		56, 67, 70, 72, 44, 70, 75, 77,
		79, 67, 70, 72, 87, 70, 77, 75
	], inf),
	\dur, 0.5,
	\legato, 0.3,
).play(TempoClock.new(110/60));
)

(
Pbind(
	\instrument, "synth3",
	\midinote, Pseq([
		56, 67, 70, 72, 44, 70, 75, 77,
		79, 67, 70, 72, 87, 70, 77, 75
	], inf),
	\dur, 0.5,
	\sustain, 0.25,
).play(TempoClock.new(110/60));
)

(
Pbind(
	\instrument, \synth3,
	\midinote, Pseq([
		56, 67, 70, 72, 44, 70, 75, 77,
		79, 67, 70, 72, 84, 70, 77, 75
	], inf),
	\sustain, Pseq([
		0.5, 0.2, 0.5, 0.7, 0.5, 0.2, 0.5, 0.5,
		0.5, 0.2, 0.5, 0.2, 2.0, 0.2, 0.5, 0.5
	], inf),
	\dur, 0.5,
).play(TempoClock.new(110/60));
)
