// 今日の参考: https://note.com/sc3/n/nc12b70d2e866

s.boot;

// 下のファイルは記事内でダウンロードできます
// PATH 部分は自分の環墫に合わせて変更してください
// s は server (s.boot で使ってる s のこと)
// `\` はエスケープシーケンス判定される文字なので、PATH 表記をするときは `\\` と書く必要がある
// なお、Windows であっても / でパスを区切るようにすればOKではあります...
a = Buffer.read(s, "C:\\Users\\takum\\Downloads\\rythm01.wav")

// rythm01.wav を再生する
// NOTE: rhythm から h が抜けてるけど気にしない
a.play;


// PlayBuf のドキュメント: https://doc.sccode.org/Classes/PlayBuf.html
{
	PlayBuf.ar(2, a, 1, 1, 0, 0, 2)
}.play;

// ループ版
{PlayBuf.ar(2, a, 1, 1, 0, 1, 0)}.play;

// a のサンプル数を取得する
a.numFrames;
// a のサンプリングレートを取得する
a.sampleRate;

// ピッチを a のサンプリングレートに合わせる
{PlayBuf.ar(2, a, BufRateScale.kr(a)*1, 1, 0, 1, 2)}.play;

// SynthDef で PlayBuf を使う
(
SynthDef("buftest", {
	arg rate=1, trig=1, stPos=0, gate=1;
	var sig, env;
	env = EnvGen.kr(Env.asr(0.001, 1.0, 0.001), gate, doneAction:2);
	sig = PlayBuf.ar(2, a, BufRateScale.kr(a)*rate, trig, stPos, 0, 2);
	Out.ar(0, sig);
}).add;
)

(
Pbind(
	\instrument, "buftest",
	\midinote, 0,
	\dur, Pseq([2, 1, 1, 1, 1, 2], inf),
	\rate, Pseq([1, 2, 0.5, 1, -1, 1], inf),
	\stPos, Pseq([0, 48000, 72000, 0, 12000, 36000], inf),
).play(TempoClock(120/60));
)
