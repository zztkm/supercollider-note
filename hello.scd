// このコードは YouTube で公開されている 「プログラミング言語で音づくり！？SuperCollider超入門」 という動画で示されたコードを写経したものになります
// 参考: https://www.youtube.com/watch?v=TcskIuQ4dLs

s.boot
Server.killAll
{
	SinOsc.ar(100, 0, 0.2)
}.play

{ Saw.ar * 0.2}.play

{ SinOsc.ar(SinOsc.ar(XLine.kr(1, 1000, 9), 0, 200, 800), 0, 0.25) }.play;

// キック
(
{
	var sin, env, freq;
	freq = EnvGen.ar(Env([200,20], 1, -4)); // curve で曲線を指定(plot で確認してみよう
	env = EnvGen.ar(Env([0,1,0], [0.01, 1]), doneAction: 2);
	sin = SinOsc.ar(freq, 0, env) * 0.2;
}.play
)

Env([200,20], 1, -10).plot

// ハイハット
(
{
	var sn, env;
	env = EnvGen.ar(Env([0,1,0], [0.01, 0.1]), doneAction: 2);
	sn = WhiteNoise.ar;
	sn = sn * env * 0.2;
	Pan2.ar(sn, 0); // Pan2 でパンを指定、これでステレオになる
}.play
)

// スネア
(
{
	var freq, sin, env;
	// リリース時間がランダムなエンベロープ配列を10個作る
	freq = EnvGen.ar(Env([0,1,0], [0.01, Array.rand(10, 0.01, 0.2)]));
	// エンヴェロープを1 ~ 10倍する
	freq = freq * Array.rand(10, 1.0, 10.0);
	// エンヴェロープを周波数にかける
	sin = SinOsc.ar(100 * freq);
	// 音量をばらつかせる
	sin = sin * Array.rand(10, 0.1, 1);
	// 音量のエンヴェロープを作成
	env = EnvGen.kr(Env.perc(0.01, 0.2), doneAction: 2);
	// 信号を足し合わせる
	(sin.sum * env * 0.3).clip(-0.3, 0.3).dup;
}.play
)