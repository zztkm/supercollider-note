// 今回はこれ: https://note.com/sc3/n/nc368a47c1304

s.boot


// pan2 クラス
(
SynthDef("synth1", {
	arg freq=440, gate=1;
	var sig, env, osc;
	env = EnvGen.kr(Env.adsr(0.01,0.6,0.5,0.2), gate, doneAction:2);
	osc = LFPulse.ar(freq);
	// -1 で左, 0 で中央, 1 で右
	sig = Pan2.ar(osc, 0);
	Out.ar(0, sig * env * 0.3)
}).play;
)

// サイン波で左右に振る (モジュレ➖️トの例
(
SynthDef("synth1", {
	arg freq=440, gate=1;
	var sig, env, osc;
	env = EnvGen.kr(Env.adsr(0.01,0.6,0.5,0.2), gate, doneAction:2);
	osc = LFPulse.ar(freq);
	sig = Pan2.ar(osc, SinOsc.kr(2));
	Out.ar(0, sig * env * 0.3)
}).add;
Pbind(
	\instrument, "synth1",
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

// ここからマルチチャンネルの話

// ar の第一引数に配列を渡すとマルチチャンネルになる
{
	SinOsc.ar([220, 220], 0, 0.3)
}.play


// NOTE: なんかプツプツ音が入るけど、これはなんでだろう...
{ Splay.ar(SinOsc.ar([220, 222], 0, 0.3), 0.5) }.play;

SynthDef(\name, {Out.ar(0, SinOsc.ar([220, 222], 0, 0.3))}).play;

SynthDef(\name, {Out.ar(0, Mix(SinOsc.ar([220, 222, 660], 0, 0.1))!2)}).play;

